import { ButtonInteraction, GuildMember, Interaction, Message, MessageActionRow, MessageButton, MessageEmbed, MessageSelectMenu, SelectMenuInteraction } from "discord.js"
import Materias from '../../../data/materias.json'
import Logger from '../../Logger'
import Configs from '../../config.json'
import ExtendedClient from "../../Client"
import { Materia, MateriaData } from "../../Persistence/Types/Materia"
import moment, { Moment } from "moment"
import makeInterval from 'iso8601-repeating-interval'
import * as chrono from 'chrono-node';
import { Reminder, ReminderData, ReminderScope, ReminderType } from "../../Persistence/Types/Reminder"
import Persistence from "../../Persistence"
import { capitalize, escapeRegExp, tryToDeleteMessage } from "../../Utils"
const log = Logger(Configs.EventsLogLevel, 'manageReminders.ts')

export async function manageReminders(client: ExtendedClient, interaction: ButtonInteraction) {
    let currentInteraction: Interaction = interaction;
    let materia: Materia = getMateriaFromTextChannel(interaction.channelId);

    /// get from which materia user wants to manage reminders to
    if (!materia) {
        let getMateriaFromUserResult = await getMateriaFromUser(currentInteraction as ButtonInteraction);
        currentInteraction = getMateriaFromUserResult.lastInteraction

        /// if interaction failed, stop here
        if (!currentInteraction) return;

        /// TODO: Deal with no materia case
        if (getMateriaFromUserResult.materiaID !== "all") {
            /// get materia from materiaID
            materia = { materiaID: getMateriaFromUserResult.materiaID, materiaData: Materias[getMateriaFromUserResult.materiaID] };
        }
    }

    /// show select with materias and buttons
    let menuMessage = await sendManageRemindersMenu(client, currentInteraction, materia)

    try {
        const filter = i => {
            return i.user.id === currentInteraction.user.id
        }

        /// wait for option selection
        let reminderMenuSelectInteraction = await menuMessage.awaitMessageComponent({ filter, componentType: 'SELECT_MENU', time: Configs["ButtonDefaultTimeout"] * 1000 })
        currentInteraction = reminderMenuSelectInteraction

        let chosenReminders: Reminder[] = []

        for (const chosenOption of reminderMenuSelectInteraction.values) {
            let reminder = await client.persistence.fetchReminderByID(Number(chosenOption))
            if (reminder)
                chosenReminders.push(reminder)
        }

        /// send message with selected reminders
        let chosenRemindersMessage = await sendChosenRemindersMessage(client, currentInteraction, chosenReminders, materia)

        // menuMessage.components[menuMessage.components.length - 1].components.forEach((component, index) => { component.setDisabled(false) });
        // (currentInteraction as ButtonInteraction).editReply({ components: menuMessage.components });

        let chosenReminderInteraction = await chosenRemindersMessage.awaitMessageComponent({ filter, componentType: 'BUTTON', time: Configs["ButtonDefaultTimeout"] * 1000 });
        currentInteraction = chosenReminderInteraction

        let toDisable = [true, true]
        switch (chosenReminderInteraction.customId) {
            case "showSelctedRemindersButton":

                toDisable[0] = false
                break;
            case "removeSelectedRemindersButton":
                await disableChosenReminders(client, chosenReminderInteraction, chosenReminders)
                toDisable[1] = false
                break;
        }

        // console.debug(toDisable)

        chosenRemindersMessage.components[chosenRemindersMessage.components.length - 1].components.forEach((component, index) => { component.setDisabled(toDisable[index]) });
        reminderMenuSelectInteraction.editReply({ components: chosenRemindersMessage.components });
    } catch (error) {
        console.error(error)
    }

}

function getMateriaFromTextChannel(channelId: string): Materia {
    for (let materiaID of Object.keys(Materias)) {
        let materia: MateriaData = Materias[materiaID]
        if (channelId === materia.canalTextoID) {
            return { materiaID, materiaData: materia }
        }
    }
    return null
}

async function getMateriaFromUser(interaction: ButtonInteraction) {
    let materiaID: string = null
    let selectCourseMessage: Message = await sendCoursesSelect(interaction)

    // console.debug(selectCourseMessage)

    if (!selectCourseMessage) return { materiaID, lastInteraction: null }

    const filter = i => {
        // i.deferUpdate();
        return i.user.id === interaction.user.id;
    };

    let selectCourseInteraction: SelectMenuInteraction = null

    /// try to send select message for user to choose
    try {
        selectCourseInteraction = await selectCourseMessage.awaitMessageComponent({ filter, componentType: 'SELECT_MENU', time: Configs["ButtonDefaultTimeout"] * 1000 })

        materiaID = selectCourseInteraction.values[0]
    } catch (error) {
        console.error(error)

        /// user waited too much to interact
        let messageContent = { content: `**😢 Você me deixou no vácuo! 😢**`, components: [] }
        interaction.editReply(messageContent)

        selectCourseInteraction = null
    }

    return { materiaID, lastInteraction: selectCourseInteraction }
}

export async function sendCoursesSelect(interaction: ButtonInteraction) {
    let messageToSend: any = {}

    /// get option of the current year
    let options = await getMemberCoursesRoles(interaction.member as GuildMember)

    /// if there are options to choose
    if (options.length > 0) {
        let defaultOption = {
            label: "Todas Matérias",
            description: "Gerenciar lembretes de todas as matérias",
            value: "all"
        }
        options = [defaultOption].concat(options)

        let optionsChunks = options.reduce((all, one, i) => {
            const ch = Math.floor(i / 25);
            all[ch] = [].concat((all[ch] || []), one);
            return all
        }, [])

        // console.debug(optionsChunks)

        let selectRows: MessageActionRow[] = []
        optionsChunks.forEach((chunk, index) => {

            let placeHolderAuxStr = (index) ? "Continuação da " : ""
            /// create row element to show
            let row = new MessageActionRow().addComponents(
                new MessageSelectMenu()
                    .setCustomId(`selectCourseSelect|${index}`)
                    .setPlaceholder(`${placeHolderAuxStr}Lista de Matérias`)
                    .addOptions(chunk),
            )

            selectRows.push(row)
        });

        /// createView
        messageToSend = {
            content: `**Selecione uma matéria para adicionar o lembrete:**`,
            components: selectRows,
            ephemeral: true,
            fetchReply: true
        }
    } else {
        messageToSend = { content: '**Você não está escrito em nenhuma matéria**', ephemeral: true, fetchReply: true }
        return null
    }

    /// send to member
    return await interaction.reply(messageToSend) as Message
}

async function getMemberCoursesRoles(member: GuildMember) {
    let selectOptions = []

    member.roles.cache.forEach(role => {
        if (role.id in Materias) {
            let materia = Materias[role.id]
            /// create description string
            let materiaProfessoresStr = materia.professores[0].nome

            /// if there's more than 1 professor, apply a reduce
            if ((materia.professores.length > 1))
                materiaProfessoresStr = materia.professores.reduce((prev: { nome: string }, curr: { nome: string }) => { return `${prev.nome}, ${curr.nome}` })

            selectOptions.push({
                label: materia.nomeMateria,
                description: `${materiaProfessoresStr}`,
                value: `${role.id}`,
            })
        }
    })

    return selectOptions
}

async function sendManageRemindersMenu(client: ExtendedClient, interaction: Interaction, materia: Materia) {
    let reminders: Reminder[] = [];
    if(!materia) {
        reminders = await client.persistence.fetchRemindersByAuthor(interaction.user.id, ReminderScope.Personal)
    } else {
        reminders = await client.persistence.fetchRemindersByMateriaID(materia.materiaID, ReminderScope.Personal, interaction.user.id)
    }

    let filteredReminders = reminders.filter(reminder => {
        return (reminder.reminderData.disabled === false)
    });

    let options = filteredReminders.map(reminder => {
        let optionLabel = `Lembrete de ${capitalize(reminder.reminderData.type)}`
        optionLabel += (reminder.reminderData.dueDate) ? ` para ${moment(reminder.reminderData.dueDate).format("L LT")}` : ``;
        return {
            label: optionLabel,
            description: reminder.reminderData.description.substring(0, 60) + ((reminder.reminderData.description.length > 60) ? '[...]' : ''),
            value: reminder.reminderID.toString()
        }
    })

    /// divide options in 25 chunks
    let optionsChunks = options.reduce((all, one, i) => {
        const ch = Math.floor(i / 25);
        all[ch] = [].concat((all[ch] || []), one);
        return all
    }, [])

    let components: MessageActionRow[] = []
    let embeds: MessageEmbed[] = []
    if (reminders.length > 0) {
        optionsChunks.forEach((chunk, index) => {
            if (index > 4) return;

            console.debug({ chunk })

            let placeHolderAuxStr = (index) ? "Continuação da " : ""
            /// create row element to show
            let row = new MessageActionRow().addComponents(
                new MessageSelectMenu()
                    .setCustomId(`selectReminderSelect|${index}`)
                    .setPlaceholder(`${placeHolderAuxStr}Lista de Lembretes`)
                    .addOptions(chunk)
                    .setMaxValues(chunk.length),
            )

            components.push(row)
        });

    } else {
        let noRemindersEmbed = new MessageEmbed()
            .setColor('#4f258a')
            .setTitle('Lembretes:')
            .setDescription(`**Não há lembretes para esta matéria.**\n\nOBS: Você pode adicionar lembretes de tarefas, trabalhos, provas e anotações por meio do comando \`${global.dataState.prefix}lembrete\``)
            .setTimestamp()
            .setFooter((interaction.member as GuildMember).displayName, (interaction.member as GuildMember).displayAvatarURL());

        embeds.push(noRemindersEmbed)
    }

    let messageToSend: any = { content: "**Selecione as matérias que deseja Desativar:**", components, embeds, ephemeral: true, fetchReply: true }
    return await (interaction as ButtonInteraction).reply(messageToSend) as Message
}


async function sendChosenRemindersMessage(client: ExtendedClient, interaction: Interaction, reminders: Reminder[], materia?: Materia) {
    let interactionAuthor = interaction.member as GuildMember

    let today = moment().startOf('day')
    reminders = reminders.filter((reminder) => { return today < moment(reminder.reminderData.dueDate) })
    reminders = reminders.sort((a, b) => { return (moment(a.reminderData.dueDate) < moment(b.reminderData.dueDate) ? -1 : 1) })

    // console.debug("author:")
    // console.debug(author.displayName)

    let components: MessageActionRow[] = []
    let embedsToSend: MessageEmbed[] = []
    if (reminders.length > 0) {
        for (let ind = 0; ind < reminders.length / 25 && ind < 10; ++ind) {
            let currentReminders = reminders.splice(ind * 25, 25)

            let embedDesc = "Lista de lembretes para gerenciar"
            if (materia) {
                embedDesc += ` da matéria de \`${materia.materiaData.nomeMateria}\`.`
            } else {
                embedDesc += `.`
            }
            let reminderEmbed = new MessageEmbed()
                .setColor('#4f258a')
                .setTitle('Lembretes')
                .setDescription(embedDesc)
                .setTimestamp()
                .setFooter(interactionAuthor.displayName, interactionAuthor.displayAvatarURL());

            for (let reminder of currentReminders) {
                let reminderAuthor = await interaction.guild.members.fetch(reminder.reminderData.author)
                let reminderTitle = `Lembrete de ${capitalize(reminder.reminderData.type)} de ${reminderAuthor.displayName}`
                reminderTitle += (reminder.reminderData.dueDate) ? ` <t:${moment(reminder.reminderData.dueDate).unix()}:R>` : ``;
                let reminderDescStr = reminder.reminderData.description.substring(0, 165).concat((reminder.reminderData.description.length > 150) ? `[...]` : ``)
                let reminderDesc = `\
                \`\`\`\n${reminderDescStr}\n\`\`\`\
                [Mensagem](${reminder.reminderData.descriptionURL} 'Link para a mensagem da anotação')\n\u200b\
            `
                reminderEmbed.addField(reminderTitle, reminderDesc, false)
            }

            embedsToSend.push(reminderEmbed)
        }

        let buttonRow = new MessageActionRow().addComponents(
            new MessageButton()
                .setCustomId("removeSelectedRemindersButton")
                .setEmoji("🗑️")
                .setLabel("Lixeira")
                .setStyle("DANGER")
                .setDisabled(false),
        )
        components.push(buttonRow)

    } else {
        let noRemindersEmbed = new MessageEmbed()
            .setColor('#4f258a')
            .setTitle('Reminder:')
            .setDescription(`**How did this happen to you?\n you did your mistakes.**`)
            .setTimestamp()
            .setFooter(interactionAuthor.displayName, interactionAuthor.displayAvatarURL());

        embedsToSend.push(noRemindersEmbed)
    }

    let messageContent: any = { content: `\u200b`, embeds: embedsToSend, components: components, ephemeral: true, fetchReply: true };
    let showRemindersMessage: Message = await (interaction as ButtonInteraction).reply(messageContent) as Message;

    return showRemindersMessage
}

async function disableChosenReminders(client: ExtendedClient, interaction: ButtonInteraction, chosenReminders: Reminder[]) {
    /// upsert disable reminders to persistence
    for (let reminder of chosenReminders) {
        reminder.reminderData.disabled = true
        console.debug({reminder})
        await client.persistence.upsertReminder(reminder.reminderID, reminder.reminderData)
    }

    await interaction.reply({ ephemeral: true, content: `🗑️ **Os lembretes selecionados forão desativados.** 🗑️`, components: [] })
}
