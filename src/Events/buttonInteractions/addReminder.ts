import { ButtonInteraction, GuildMember, Interaction, Message, MessageActionRow, MessageButton, MessageCollector, MessageInteraction, MessageSelectMenu, SelectMenuInteraction, TextChannel } from "discord.js"
import Materias from '../../../data/materias.json'
import Logger from '../../Logger'
import Configs from '../../config.json'
import ExtendedClient from "../../Client"
import { Materia } from "../../Persistence/Materia"
import moment, { Moment } from "moment"
import makeInterval from 'iso8601-repeating-interval'
import * as chrono from 'chrono-node';
import { Horario } from "../../Persistence/Horario"
const log = Logger(Configs.EventsLogLevel, 'addReminder.ts')

export async function addReminder(client: ExtendedClient, interaction: ButtonInteraction, reminderType: string) {
    let currentInteraction: Interaction = interaction;
    let materiaID: string = interaction.channelId;
    let materia: Materia = getCourseTextChannel(interaction.channelId);

    /// get from which materia user wants to add reminder to
    if (!materia) {
        let getMateriaFromUserResult = await getMateriaFromUser(interaction);
        currentInteraction = getMateriaFromUserResult.lastInteraction

        if (!currentInteraction) return;

        materiaID = getMateriaFromUserResult.materiaID
        materia = Materias[materiaID];
    }

    /// get reminder date from user
    let reminderDateResult = await getReminderDate(currentInteraction, materiaID);
    let date: Moment = reminderDateResult.date;
    currentInteraction = reminderDateResult.lastInteraction;

    if (!currentInteraction) return;

}

function getCourseTextChannel(channelId: string) {
    for (let materiaID of Object.keys(Materias)) {
        let materia: Materia = Materias[materiaID]
        if (channelId === materia.canalTextoID) {
            return materia
        }
    }
    return null
}

async function getMateriaFromUser(interaction: ButtonInteraction) {
    let materiaID: string = null
    let selectCourseMessage: Message = await sendCoursesSelect(interaction)

    console.debug(selectCourseMessage)

    const filter = i => {
        // i.deferUpdate();
        return i.user.id === interaction.user.id;
    };

    let selectCourseInteraction: SelectMenuInteraction = null

    try {
        selectCourseInteraction = await selectCourseMessage.awaitMessageComponent({ filter, componentType: 'SELECT_MENU', time: 60000 })

        materiaID = selectCourseInteraction.values[0]
    } catch (error) {
        console.error(error)

        let messageContent = { content: `**😢 Demorou demais para responder 😢**`, components: [] }
        interaction.editReply(messageContent)
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

async function getReminderDate(interaction: Interaction, materiaID: string) {
    let reminderDate: Moment = null;
    let currentInteraction: Interaction = null;
    let getDateInteraction: ButtonInteraction = null;

    try {
        let reminderMessage: Message = await sendReminderDateMenu(interaction, materiaID)

        const filter = i => {
            // i.deferUpdate();
            return i.user.id === interaction.user.id;
        };
        try {
            getDateInteraction = await reminderMessage.awaitMessageComponent({ filter, componentType: 'BUTTON', time: 60000 });
            currentInteraction = getDateInteraction;
        } catch (error) {
            console.error(error)

            let messageContent = { content: `**😢 Demorou demais para responder 😢**`, components: [] }
            await getDateInteraction.editReply(messageContent)

            currentInteraction = null
        }

        if (currentInteraction) {
            /// fetch user reply
            let userChoice = (getDateInteraction as ButtonInteraction).customId

            switch (userChoice) {
                case "getReminderDate|nextClass":
                    reminderDate = await getNextClassFromMateria(materiaID)
                    break;
                case "getReminderDate|typeDate":
                    await (getDateInteraction as ButtonInteraction).deferUpdate();
                    let getDateFromMessageResult = await getDateFromMessage(currentInteraction)
                    reminderDate = getDateFromMessageResult.date
                    currentInteraction = getDateFromMessageResult.lastInteraction
                    break;
                case "getReminderDate|noDate":
                    reminderDate = null
                    break;
                case "getReminderDate|cancel":
                    await (getDateInteraction as ButtonInteraction).editReply({ content: `Entendi...\nA criação do lembrete foi cancelada.` })
                    break;
            }

            console.debug(reminderDate.format())
        }

    } catch (error) {
        console.error(error)
    }

    return { date: reminderDate, lastInteraction: currentInteraction }
}

async function sendReminderDateMenu(interaction: Interaction, materiaID: string) {
    let reminderDateView: any = {}

    /// create select with each year
    let firstRow = new MessageActionRow().addComponents(
        new MessageButton()
            .setCustomId('getReminderDate|nextClass')
            .setEmoji("")
            .setLabel('Proxima Aula')
            .setStyle('PRIMARY')
            .setDisabled(materiaID === "none"),
        new MessageButton()
            .setCustomId('getReminderDate|typeDate')
            .setEmoji("")
            .setLabel("Digitar Data")
            .setStyle("PRIMARY"),
        new MessageButton()
            .setCustomId('getReminderDate|noDate')
            .setEmoji("")
            .setLabel("Não Sei")
            .setStyle("PRIMARY"),
        new MessageButton()
            .setCustomId('getReminderDate|cancel')
            .setEmoji("")
            .setLabel("Cancelar")
            .setStyle("DANGER"),
    )

    /// create view
    reminderDateView = {
        content: "**Por favor,\ndiga para quando é este lembrete...**",
        components: [firstRow],
        ephemeral: true,
        fetchReply: true
    }

    /// send to member
    return await (interaction as ButtonInteraction).reply(reminderDateView) as Message
}

async function getNextClassFromMateria(materiaID: string) {
    let materia: Materia = Materias[materiaID]
    let tomorrow = moment().add(1, 'days')
    let horarios: Horario[] = materia.horarios

    let nextClass: Moment = null
    for (const horario of materia.horarios) {
        let firstAfterClass: Moment = makeInterval(horario.inicio).firstAfter(tomorrow.startOf('day')).date
        if (!nextClass || nextClass < firstAfterClass) {
            nextClass = firstAfterClass
        }
    }

    return nextClass
}

async function getDateFromMessage(interaction: Interaction) {
    let parsedDate: Moment = null

    /// create select with each year
    let firstMessageRow = new MessageActionRow().addComponents(
        new MessageButton()
            .setCustomId('getReminderDate|correct')
            .setEmoji("✅")
            .setLabel('Correto')
            .setStyle('SUCCESS'),
        new MessageButton()
            .setCustomId('getReminderDate|toCorrect')
            .setEmoji("❌")
            .setLabel("Arrumar")
            .setStyle("DANGER")
    )

    /// create select with each year
    let secondMessageRow = new MessageActionRow().addComponents(
        new MessageButton()
            .setCustomId('getReminderDate|cancel')
            .setEmoji("❌")
            .setLabel("Cancelar")
            .setStyle("DANGER")
    )

    let currentInteraction: Interaction = null
    let messageContent = { content: "**Digite a data do lembrete...**", components: [] }

    while (!parsedDate) {

        const filterAuthor = i => {
            return i.author.id === interaction.user.id;
        };

        await (interaction as ButtonInteraction).editReply(messageContent);

        /// with collection
        let messageCollection = await (interaction as ButtonInteraction).channel.awaitMessages({ filter: filterAuthor, max: 1, errors: ['time'], time: 60000 })
        let messageResponse = messageCollection.first()

        parsedDate = parseDateCustom(messageResponse.content)
        messageResponse.delete()
        console.debug({ parsedDate })

        if (!parsedDate.isValid()) {
            messageContent = { content: `**Não entendi...\n Por favor, digite a data novamente...**`, components: [secondMessageRow] }
            parsedDate = null
        } else {
            messageContent = { content: `**O lembrete será: <t:${parsedDate.unix()}:R>**`, components: [firstMessageRow] }
            let reminderDateMenuMessage: Message = await (interaction as ButtonInteraction).editReply(messageContent) as Message;

            const filterMember = i => {
                i.deferUpdate();
                return i.member.id === interaction.user.id;
            };

            const onTimeout = reason => { }
            let getDateInteraction: ButtonInteraction = null
            try {
                getDateInteraction = await reminderDateMenuMessage.awaitMessageComponent({ filter: filterMember, componentType: 'BUTTON', time: 60000 })
                currentInteraction = getDateInteraction
            } catch (error) {
                console.error(error)

                messageContent = { content: `**😢 Demorou demais para responder 😢**`, components: [] }
                await (interaction as ButtonInteraction).editReply(messageContent)

                currentInteraction = null
            }

            console.debug({ getDateInteraction })
            console.debug(getDateInteraction.customId)

            if (getDateInteraction.customId === "getReminderDate|toCorrect") {
                parsedDate = null
                messageContent = { content: `**Digite a data do lembrete novamente...**`, components: [] }
            }
        }
    }

    messageContent = { content: `**O lembrete será: <t:${parsedDate.unix()}:R>**`, components: [] }
    await (interaction as ButtonInteraction).editReply(messageContent) as Message;

    return { date: parsedDate, lastInteraction: currentInteraction }
}

function parseDateCustom(dateStr: string) {
    const custom = chrono.pt.casual.clone();
    custom.refiners.push({
        refine: (context, results) => {
            /// If no hour specified,
            results.forEach((result) => {
                /// let hour be 0
                if (!result.start.isCertain("hour")) {
                    result.start.assign('hour', 0)
                }
            });
            return results;
        }
    });

    return moment(custom.parseDate(dateStr, moment().startOf('day').toDate(), { forwardDate: true }))
}