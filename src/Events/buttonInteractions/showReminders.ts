import { ButtonInteraction, GuildMember, Interaction, Message, MessageActionRow, MessageButton, MessageEmbed, MessageSelectMenu, SelectMenuInteraction } from "discord.js"
import Materias from '../../../data/materias.json'
import Logger from '../../Logger'
import Configs from '../../config.json'
import ExtendedClient from "../../Client"
import { Materia, MateriaData } from "../../Persistence/Materia"
import { Reminder, ReminderScope } from "../../Persistence/Reminder"
import moment from "moment"
const log = Logger(Configs.EventsLogLevel, 'addReminder.ts')

export async function showReminders(client: ExtendedClient, interaction: ButtonInteraction) {
    let materiaID: string = interaction.channelId;
    let materia: Materia = getCourseTextChannel(interaction.channelId);
    let currentInteraction: Interaction = interaction;
    let reminderScope: ReminderScope = null

    if ((interaction.member as GuildMember).roles.cache.has(process.env.CONFIAVEL_ROLE_ID)) {
        /// send reminder scope menu message
        let sendAddReminderMenuResult = await getScopeOfReminder(interaction)
        reminderScope = sendAddReminderMenuResult.reminderScope
        currentInteraction = sendAddReminderMenuResult.lastInteraction
    } else {
        reminderScope = ReminderScope.Personal
    }

    /// get from which materia user wants to show reminders
    if (!materia) {
        let getMateriaFromUserResult = await getMateriaFromUser(currentInteraction as ButtonInteraction);
        currentInteraction = getMateriaFromUserResult.lastInteraction

        /// if interaction failed, stop here
        if (!currentInteraction) return;

        /// get materia from materiaID
        materiaID = getMateriaFromUserResult.materiaID
        materia = Materias[materiaID];
    }

    await showRemindersFromMateria(client, currentInteraction, materia, reminderScope)
}

function getCourseTextChannel(channelId: string): Materia {
    for (let materiaID of Object.keys(Materias)) {
        let materia: MateriaData = Materias[materiaID]
        if (channelId === materia.canalTextoID) {
            return { materiaID: channelId, materiaData: materia }
        }
    }
    return null
}

async function getScopeOfReminder(interaction: ButtonInteraction) {
    let reminderScope: ReminderScope = null

    let reminderMenuMessage: Message = await sendAddReminderMenu(interaction)

    let addReminderMenuInteraction: ButtonInteraction = null
    try {
        const filter = i => {
            return i.user.id === interaction.user.id
        }
        addReminderMenuInteraction = await reminderMenuMessage.awaitMessageComponent({ filter, componentType: 'BUTTON', time: Configs["ButtonDefaultTimeout"] * 1000 })

        let toDisable = [true, true]
        switch (addReminderMenuInteraction.customId) {
            case "reminderScope|public":
                reminderScope = ReminderScope.Public
                toDisable[0] = false
                break;
            case "reminderScope|personal":
                reminderScope = ReminderScope.Personal
                toDisable[1] = false
                break;
        }

        console.debug(toDisable)

        reminderMenuMessage.components[0].components.forEach((component, index) => { component.setDisabled(toDisable[index]) })
        interaction.editReply({ components: reminderMenuMessage.components });
    } catch (error) {
        console.error(error)

        /// user waited too much to interact
        let messageContent = { content: `**😢 Você me deixou no vácuo! 😢**`, components: [] }
        interaction.editReply(messageContent)

        addReminderMenuInteraction = null
    }

    return { reminderScope, lastInteraction: addReminderMenuInteraction }
}


async function sendAddReminderMenu(interaction: ButtonInteraction) {
    let scopeChoiceView: any = {}

    /// create select with
    let firstRow = new MessageActionRow().addComponents(
        new MessageButton()
            .setCustomId('reminderScope|public')
            .setEmoji("🔓")
            .setLabel('Público')
            .setStyle('PRIMARY'),
        new MessageButton()
            .setCustomId('reminderScope|personal')
            .setEmoji("🔐")
            .setLabel("Pessoal")
            .setStyle("PRIMARY"),
    )
    /// create view
    scopeChoiceView = {
        content: "**Qual escopo de lembrete deseja ver?**",
        components: [firstRow],
        ephemeral: true,
        fetchReply: true
    }

    /// send view to channel
    return await interaction.reply(scopeChoiceView) as Message
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
            label: "Nenhuma Matéria",
            description: "Não atrelar o lembrete a uma matéria especifica",
            value: "none"
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

async function showRemindersFromMateria(client: ExtendedClient, interaction: Interaction, materia: Materia, reminderScope: ReminderScope) {
    let reminders: Reminder[] = await client.persistence.fetchRemindersByMateriaID(materia.materiaID, interaction.user.id, reminderScope)
    let author = interaction.member as GuildMember

    console.debug(reminders)

    let embedsToSend: MessageEmbed[] = []
    for (let ind = 0; ind < 10; ++ind) {
        let currentReminders = reminders.splice(ind * 25, 25)

        let embedDesc = ""
        if (materia) {
            embedDesc = `Lista de lembretes de escopo ${reminderScope} da matéria de \`${materia.materiaData.nomeMateria}\``
        } else {
            embedDesc = `Lista de lembretes de escopo ${reminderScope}`
        }
        let reminderEmbed = new MessageEmbed()
            .setColor('#4f258a')
            .setTitle('Lembretes')
            .setDescription(embedDesc)
            .setTimestamp()
            .setFooter(author.nickname, author.displayAvatarURL());

        for (let reminder of currentReminders) {
            let reminderTitle = `[Mensagem](${reminder.reminderData.descriptionURL} Link para a mensagem da anotação')`
            let reminderDesc = `<t:${moment(reminder.reminderData.dueDate).unix()}:R>\`\`\`${reminder.reminderData.description}\`\`\``

            reminderEmbed.addField(reminderTitle, reminderDesc, false)
        }

        embedsToSend.push(reminderEmbed)
    }

    let messageContent: any = { content: `**Lembretes:**`, embeds: embedsToSend, components: [], ephemeral: true, fetchReply: true };
    let showRemindersMessage = await (interaction as ButtonInteraction).reply(messageContent)

}