import { ButtonInteraction, GuildMember, Interaction, Message, MessageActionRow, MessageButton, MessageEmbed, MessageSelectMenu, SelectMenuInteraction } from "discord.js"
import Materias from '../../../data/materias.json'
import Logger from '../../Logger'
import Configs from '../../config.json'
import ExtendedClient from "../../Client"
import { Materia, MateriaData } from "../../Persistence/Materia"
import moment, { Moment } from "moment"
import makeInterval from 'iso8601-repeating-interval'
import * as chrono from 'chrono-node';
import { ReminderData, ReminderScope, ReminderType } from "../../Persistence/Reminder"
import Persistence from "../../Persistence"
import { capitalize, escapeRegExp, tryToDeleteMessage } from "../../Utils"
const log = Logger(Configs.EventsLogLevel, 'addReminder.ts')

export async function addReminder(client: ExtendedClient, interaction: ButtonInteraction) {
    let currentInteraction: Interaction = interaction;
    let reminderType: ReminderType = null
    let materia: Materia = getMateriaFromTextChannel(interaction.channelId);

    /// send add reminder menu message
    let sendAddReminderMenuResult = await getTypeOfReminder(interaction)
    reminderType = sendAddReminderMenuResult.reminderType
    currentInteraction = sendAddReminderMenuResult.lastInteraction

    /// get from which materia user wants to add reminder to
    if (!materia) {
        let getMateriaFromUserResult = await getMateriaFromUser(currentInteraction as ButtonInteraction);
        currentInteraction = getMateriaFromUserResult.lastInteraction

        /// if interaction failed, stop here
        if (!currentInteraction) return;

        /// get materia from materiaID
        materia = { materiaID: getMateriaFromUserResult.materiaID, materiaData: Materias[getMateriaFromUserResult.materiaID] };
    }

    /// get reminder date from user
    let reminderDateResult = await getReminderDate(currentInteraction, materia.materiaID);
    let date: Moment = reminderDateResult.date;
    currentInteraction = reminderDateResult.lastInteraction;

    /// if interaction failed, stop here
    if (!currentInteraction) return;

    /// get reminder description from user
    let getReminderDescriptionResult = await getReminderDescription(currentInteraction);
    let description: Message = getReminderDescriptionResult.description;
    currentInteraction = getReminderDescriptionResult.lastInteraction;

    /// if interaction failed, stop here
    if (!currentInteraction) return;

    /// get final reminder
    let getFinalReminderResult = await getFinalReminder(currentInteraction as ButtonInteraction, materia, reminderType, date, description)
    let reminderData: ReminderData = getFinalReminderResult.reminderData;
    currentInteraction = getFinalReminderResult.lastInteraction;

    /// if interaction failed, stop here
    if (!currentInteraction) return;

    /// defer reply
    await (currentInteraction as ButtonInteraction).deferReply({ephemeral: true})

    /// save reminder
    await client.persistence.upsertReminder(0, reminderData)

    /// reply confiming save
    await (currentInteraction as ButtonInteraction).editReply(`**💾 Lembrete Salvo. 💾**`)
}

async function getTypeOfReminder(interaction: ButtonInteraction) {
    let reminderType: ReminderType = null

    let reminderMenuMessage: Message = await sendAddReminderMenu(interaction)

    let addReminderMenuInteraction: ButtonInteraction = null
    try {
        const filter = i => {
            return i.user.id === interaction.user.id
        }
        addReminderMenuInteraction = await reminderMenuMessage.awaitMessageComponent({ filter, componentType: 'BUTTON', time: Configs["ButtonDefaultTimeout"] * 1000 })

        let toDisable = [true, true, true, true]
        switch (addReminderMenuInteraction.customId) {
            case "reminderType|note":
                reminderType = ReminderType.Note
                toDisable[0] = false
                break;
            case "reminderType|assignment":
                reminderType = ReminderType.Assignment
                toDisable[1] = false
                break;
            case "reminderType|exam":
                reminderType = ReminderType.Exam
                toDisable[2] = false
                break;
            case "reminderType|project":
                reminderType = ReminderType.Project
                toDisable[3] = false
                break;
        }

        reminderMenuMessage.components[0].components.forEach((component, index) => { component.setDisabled(toDisable[index]) })
        interaction.editReply({ components: reminderMenuMessage.components });
    } catch (error) {
        console.error(error)

        /// user waited too much to interact
        let messageContent = { content: `**😢 Você me deixou no vácuo! 😢**`, components: [] }
        interaction.editReply(messageContent)

        addReminderMenuInteraction = null
    }

    return { reminderType, lastInteraction: addReminderMenuInteraction }
}

async function sendAddReminderMenu(interaction: ButtonInteraction) {
    let managementView: any = {}

    /// create select with
    let firstRow = new MessageActionRow().addComponents(
        new MessageButton()
            .setCustomId('reminderType|note')
            .setEmoji("📓")
            .setLabel('Anotação')
            .setStyle('PRIMARY'),
        new MessageButton()
            .setCustomId('reminderType|assignment')
            .setEmoji("📑")
            .setLabel("Exercício")
            .setStyle("PRIMARY"),
        new MessageButton()
            .setCustomId('reminderType|exam')
            .setEmoji("📝")
            .setLabel("Prova")
            .setStyle("PRIMARY"),
        new MessageButton()
            .setCustomId('reminderType|project')
            .setEmoji("📖")
            .setLabel("Trabalho")
            .setStyle("PRIMARY"),
    )
    /// create view
    managementView = {
        content: "**Qual tipo de lembrete deseja adicionar?**",
        components: [firstRow],
        ephemeral: true,
        fetchReply: true
    }

    /// send view to channel
    return await interaction.reply(managementView) as Message
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
            getDateInteraction = await reminderMessage.awaitMessageComponent({ filter, componentType: 'BUTTON', time: Configs["ButtonDefaultTimeout"] * 1000 });
            currentInteraction = getDateInteraction;
        } catch (error) {
            console.error(error)

            let messageContent = { content: `**😢 Você me deixou no vácuo! 😢**`, components: [] }
            await getDateInteraction.editReply(messageContent)

            currentInteraction = null
        }

        if (currentInteraction) {
            /// fetch user reply
            let userChoice = (getDateInteraction as ButtonInteraction).customId

            let toDisable = [true, true, true, true]
            switch (userChoice) {
                case "getReminderDate|nextClass":
                    await (getDateInteraction as ButtonInteraction).deferUpdate();
                    let getNextClassFromMateriaResult = await getNextClassFromMateria(interaction, materiaID)
                    reminderDate = getNextClassFromMateriaResult.date
                    currentInteraction = getNextClassFromMateriaResult.lastInteraction
                    toDisable[0] = false
                    break;
                case "getReminderDate|typeDate":
                    await (getDateInteraction as ButtonInteraction).deferUpdate();
                    let getDateFromMessageResult = await getDateFromMessage(interaction)
                    reminderDate = getDateFromMessageResult.date
                    currentInteraction = getDateFromMessageResult.lastInteraction
                    toDisable[1] = false
                    break;
                case "getReminderDate|noDate":
                    // let noDateMenuResult = await noDateMenu(interaction)
                    reminderDate = null;
                    // currentInteraction = noDateMenuResult.lastInteraction
                    // (currentInteraction as ButtonInteraction).followUp({content: `**Sem data definida.**`, ephemeral: true})
                    toDisable[2] = false
                    break;
                case "getReminderDate|cancel":
                    await (getDateInteraction as ButtonInteraction).editReply({ content: `Entendi...\nA criação do lembrete foi cancelada.` })
                    toDisable[3] = false
                    break;
            }

            reminderMessage.components[0].components.forEach((component, index) => { component.setDisabled(toDisable[index]) });
            await (interaction as ButtonInteraction).editReply({ components: reminderMessage.components });
            // if((interaction as ButtonInteraction).replied || (interaction as ButtonInteraction).deferred) {

            // }

            // console.debug(reminderDate.format())
        }

    } catch (error) {
        console.error(error)
    }

    return { date: reminderDate, lastInteraction: currentInteraction }
}

async function sendReminderDateMenu(interaction: Interaction, materiaID: string) {
    let reminderDateView: any = {}

    /// create select with
    let firstRow = new MessageActionRow().addComponents(
        new MessageButton()
            .setCustomId('getReminderDate|nextClass')
            .setEmoji("")
            .setLabel('Próxima Aula')
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

async function getNextClassFromMateria(interaction: Interaction, materiaID: string) {
    let materia: MateriaData = Materias[materiaID]
    let tomorrow = moment().add(1, 'days').startOf('day')
    console.debug(materiaID)

    let nextClass: Moment = null
    for (const horario of materia.horarios) {
        let firstAfterClass: Moment = makeInterval(horario.inicio).firstAfter(tomorrow).date
        if (!nextClass || firstAfterClass < nextClass) {
            nextClass = firstAfterClass
        }
    }

    let currentInteraction: Interaction = null

    /// create select with
    let firstMessageRow = new MessageActionRow().addComponents(
        new MessageButton()
            .setCustomId('getReminderDate|correct')
            .setEmoji("✅")
            .setLabel('Correto')
            .setStyle('SUCCESS'),
        new MessageButton()
            .setCustomId('getReminderDate|toCorrect')
            .setEmoji("❌")
            .setLabel("Cancelar")
            .setStyle("DANGER")
    )

    let messageContent: any = { content: `**O lembrete será: <t:${nextClass.unix()}:R>**`, components: [firstMessageRow], fetchReply: true, ephemeral: true }
    let reminderDateMenuMessage: Message = await (interaction as ButtonInteraction).editReply(messageContent) as Message;
    console.debug({ reminderDateMenuMessage })

    const filterMember = i => {
        // i.deferUpdate();
        return i.member.id === interaction.user.id;
    };

    let getDateInteraction: ButtonInteraction = null
    try {
        getDateInteraction = await reminderDateMenuMessage.awaitMessageComponent({ filter: filterMember, componentType: 'BUTTON', time: Configs["ButtonDefaultTimeout"] * 1000 })
        currentInteraction = getDateInteraction
    } catch (error) {
        console.error(error)

        messageContent = { content: `**😢 Você me deixou no vácuo! 😢**`, components: [] }
        await (interaction as ButtonInteraction).editReply(messageContent)

        currentInteraction = null
    }

    if (getDateInteraction.customId === "getReminderDate|toCorrect") {
        nextClass = null
        messageContent = { content: `**❌ Lembrete cancelado... ❌**`, components: [] }
        await (interaction as ButtonInteraction).editReply(messageContent)
    }

    return { date: nextClass, lastInteraction: currentInteraction }
}

async function getDateFromMessage(interaction: Interaction) {
    let parsedDate: Moment = null

    /// create select with
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

    /// create select with
    let secondMessageRow = new MessageActionRow().addComponents(
        new MessageButton()
            .setCustomId('getReminderDate|cancel')
            .setEmoji("❌")
            .setLabel("Cancelar")
            .setStyle("DANGER")
    )

    let currentInteraction: Interaction = null
    let messageContent: any = { content: "**Digite a data do lembrete...**", components: [] }

    while (!parsedDate) {

        const filterAuthor = i => {
            return i.author.id === interaction.user.id;
        };

        const filterMember = i => {
            // i.deferUpdate();
            return i.member.id === interaction.user.id;
        };

        let reminderDateMenuMessage: Message = await (interaction as ButtonInteraction).editReply(messageContent) as Message;

        let messageResponse = null
        try {
            /// with collection
            let messageCollectionPromise = (interaction as ButtonInteraction).channel.awaitMessages({ filter: filterAuthor, max: 1, errors: ['time'], time: Configs["ButtonDefaultTimeout"] * 1000 })
            let getDateInteractionPromise = reminderDateMenuMessage.awaitMessageComponent({ filter: filterMember, componentType: 'BUTTON', time: Configs["ButtonDefaultTimeout"] * 1000 })
            let racePromise = await Promise.race([messageCollectionPromise, getDateInteractionPromise])

            if (racePromise instanceof ButtonInteraction) {
                messageContent = { embeds: [], content: `**❌ Lembrete cancelado... ❌**`, components: [] }
                await (interaction as ButtonInteraction).editReply(messageContent)
                return { date: null, lastInteraction: null }
            } else {
                messageResponse = racePromise.first()
            }

        } catch (error) {
            console.error(error)

            messageContent = { content: `**😢 Você me deixou no vácuo! 😢**`, components: [] }
            await (interaction as ButtonInteraction).editReply(messageContent)

            currentInteraction = null
        }

        parsedDate = parseDateCustom(messageResponse.content)
        tryToDeleteMessage(messageResponse)
        // messageResponse.delete()
        // console.debug({ parsedDate })

        if (!parsedDate.isValid()) {
            messageContent = { content: `**Não entendi...\n Por favor, digite a data novamente...**`, components: [secondMessageRow] }
            parsedDate = null
        } else {
            messageContent = { content: `**O lembrete será: <t:${parsedDate.unix()}:R>**`, components: [firstMessageRow] }
            reminderDateMenuMessage = await (interaction as ButtonInteraction).editReply(messageContent) as Message;


            let getDateInteraction: ButtonInteraction = null
            try {
                getDateInteraction = await reminderDateMenuMessage.awaitMessageComponent({ filter: filterMember, componentType: 'BUTTON', time: Configs["ButtonDefaultTimeout"] * 1000 })
                currentInteraction = getDateInteraction
            } catch (error) {
                console.error(error)

                messageContent = { content: `**😢 Você me deixou no vácuo! 😢**`, components: [] }
                await (interaction as ButtonInteraction).editReply(messageContent)

                currentInteraction = null
            }

            // console.debug({ getDateInteraction })
            // console.debug(getDateInteraction.customId)

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

async function getReminderDescription(interaction: Interaction) {
    let description: Message = null;
    let currentInteraction: Interaction = null;
    // let getDescriptionInteraction: ButtonInteraction = null;

    try {
        // let reminderMessage: Message = await sendReminderDescriptionMenu(interaction)

        // const filter = i => {
        //     // i.deferUpdate();
        //     return i.user.id === interaction.user.id;
        // };
        // try {
        //     getDescriptionInteraction = await reminderMessage.awaitMessageComponent({ filter, componentType: 'BUTTON', time: Configs["ButtonDefaultTimeout"] * 1000 });
        //     currentInteraction = getDescriptionInteraction;
        // } catch (error) {
        //     console.error(error)

        //     let messageContent = { content: `**😢 Você me deixou no vácuo! 😢**`, components: [] }
        //     await getDescriptionInteraction.editReply(messageContent)

        //     currentInteraction = null
        // }

        // if (currentInteraction) {
        //     /// fetch user reply
        //     let userChoice = (getDescriptionInteraction as ButtonInteraction).customId

        //     switch (userChoice) {
        //         case "getReminderDesc|text":

        // await (getDescriptionInteraction as ButtonInteraction).deferUpdate();
        let getDateFromMessageResult = await getDescriptionFromMessage(interaction)
        description = getDateFromMessageResult.description
        currentInteraction = getDateFromMessageResult.lastInteraction

        //         break;
        //     case "getReminderDesc|link":
        //         // await (getDescriptionInteraction as ButtonInteraction).deferUpdate();
        //         // let getDateFromMessageResult = await getDescriptionFromMessage(currentInteraction)
        //         // description = getDateFromMessageResult.date
        //         // currentInteraction = getDateFromMessageResult.lastInteraction
        //         break;
        //     case "getReminderDesc|cancel":
        //         await (getDescriptionInteraction as ButtonInteraction).editReply({ content: `Entendi...\nA criação do lembrete foi cancelada.` })
        //         break;
        // }

        // // console.debug(description.format())
        // }

    } catch (error) {
        console.error(error)
    }

    return { description, lastInteraction: currentInteraction }
}

async function sendReminderDescriptionMenu(interaction: Interaction) {
    let reminderDateView: any = {}

    /// create select with
    let firstRow = new MessageActionRow().addComponents(
        new MessageButton()
            .setCustomId('getReminderDesc|text')
            .setEmoji("")
            .setLabel('Texto')
            .setStyle('PRIMARY'),
        new MessageButton()
            .setCustomId('getReminderDesc|link')
            .setEmoji("")
            .setLabel('Link')
            .setStyle('PRIMARY'),
        new MessageButton()
            .setCustomId('getReminderDesc|cancel')
            .setEmoji("")
            .setLabel("Cancelar")
            .setStyle("DANGER"),
    )

    /// create view
    reminderDateView = {
        content: "**Qual o tipo do lembrete?...**",
        components: [firstRow],
        ephemeral: true,
        fetchReply: true
    }

    /// send to member
    return await (interaction as ButtonInteraction).reply(reminderDateView) as Message
}

async function getDescriptionFromMessage(interaction: Interaction) {
    let descriptionMessage: Message = null
    let messageContent: any = null

    /// create select with
    let firstMessageRow = new MessageActionRow().addComponents(
        new MessageButton()
            .setCustomId('getReminderDescription|correct')
            .setEmoji("✅")
            .setLabel('Correto')
            .setStyle('SUCCESS'),
        new MessageButton()
            .setCustomId('getReminderDescription|toCorrect')
            .setEmoji("❌")
            .setLabel("Arrumar")
            .setStyle("DANGER")
    )

    /// create select with
    let secondMessageRow = new MessageActionRow().addComponents(
        new MessageButton()
            .setCustomId('getReminderDescription|cancel')
            .setEmoji("❌")
            .setLabel("Cancelar")
            .setStyle("DANGER")
    )

    let currentInteraction: Interaction = null
    messageContent = { content: "**Digite o lembrete...**", components: [], ephemeral: true }
    let currentMessage: Message = null
    // if((interaction as ButtonInteraction).deferred || (interaction as ButtonInteraction).replied) {
    //     currentMessage = await (interaction as ButtonInteraction).followUp(messageContent) as Message;
    // } else {
    // }
    currentMessage = await (interaction as ButtonInteraction).reply(messageContent) as Message;

    while (!descriptionMessage) {

        // await currentMessage.edit(messageContent)
        await (interaction as ButtonInteraction).editReply(messageContent);

        const filterAuthor = i => {
            return i.author.id === interaction.user.id;
        };

        /// with collection
        let messageCollection = await (interaction as ButtonInteraction).channel.awaitMessages({ filter: filterAuthor, max: 1, errors: ['time'], time: Configs["ButtonDefaultTimeout"] * 1000 })
        let messageResponse = messageCollection.first()

        descriptionMessage = messageResponse
        // messageResponse.delete()
        // console.debug({ parsedDate })

        if (descriptionMessage.content.replace(/ /g, '').length < 5) {
            messageContent = { content: `**Não entendi...\n Digite a mensagem do lembrete novamente...**`, components: [secondMessageRow] }
            descriptionMessage = null
        } else {

            let escapedMessage = escapeRegExp(descriptionMessage.content)
            messageContent = { content: `**a mensagem do lembrete ficará assim...**\n\`\`\`\n${escapedMessage}\n\`\`\``, components: [firstMessageRow] }
            let reminderDescriptionMenuMessage: Message = await (interaction as ButtonInteraction).editReply(messageContent) as Message;

            const filterMember = i => {
                return i.member.id === interaction.user.id;
            };

            let getDescriptionInteraction: ButtonInteraction = null
            try {
                getDescriptionInteraction = await reminderDescriptionMenuMessage.awaitMessageComponent({ filter: filterMember, componentType: 'BUTTON', time: Configs["ButtonDefaultTimeout"] * 1000 })
                currentInteraction = getDescriptionInteraction
            } catch (error) {
                console.error(error)

                messageContent = { content: `**😢 Você me deixou no vácuo! 😢**`, components: [] }
                await (interaction as ButtonInteraction).editReply(messageContent)

                currentInteraction = null
            }

            if (getDescriptionInteraction.customId === "getReminderDescription|toCorrect") {
                await tryToDeleteMessage(descriptionMessage)
                getDescriptionInteraction.deferUpdate()

                descriptionMessage = null
                messageContent = { content: `**Digite a mensagem do lembrete novamente...**`, components: [] }
            }
        }
    }

    messageContent = { content: `**O lembrete será:**\n\`\`\`${descriptionMessage.content}\`\`\``, components: [] }
    await (interaction as ButtonInteraction).editReply(messageContent) as Message;

    return { description: descriptionMessage, lastInteraction: currentInteraction }
}

async function getFinalReminder(interaction: ButtonInteraction, materia: Materia, reminderType: ReminderType, date: Moment, description: Message) {
    let reminderData: ReminderData = Persistence.createReminderData();
    let author = description.author
    let messageContent: any = null;
    let remindEmbedMessage = null;
    let currentInteraction = null;

    console.debug(reminderType)

    /// confirm/cancel buttons
    let viewComponents = new MessageActionRow().addComponents(
        new MessageButton()
            .setCustomId('showReminder|confirm')
            .setEmoji("✅")
            .setLabel("Confirmar")
            .setStyle("SUCCESS"),
        new MessageButton()
            .setCustomId('showReminder|cancel')
            .setEmoji("❌")
            .setLabel("Cancelar")
            .setStyle("DANGER"),
    );

    let embedDesc = `Lembrete de \`${capitalize(reminderType)}\``
    if (date) {
        if (materia.materiaData) {
            embedDesc += ` para a matéria de \`${materia.materiaData.nomeMateria}\`.\n<t:${date.unix()}:R>`
        } else {
            embedDesc += `.\n<t:${date.unix()}:R>`
        }
    } else {
        if (materia.materiaData) {
            embedDesc += ` para a matéria de \`${materia.materiaData.nomeMateria}\`.\nPor tempo indeterminado.`
        } else {
            embedDesc += `.\nPor tempo indeterminado.`
        }
    }

    /// embed template for single reminder
    const embedToSend = new MessageEmbed()
        .setColor('#4f258a')
        .setTitle('Link da Mensagem')
        .setURL(description.url)
        .setAuthor(author.username, author.displayAvatarURL())
        .setDescription(embedDesc)
        // .setThumbnail('https://i.imgur.com/AfFp7pu.png')
        // .addFields(
        //     { name: 'Regular field title', value: 'Some value here' },
        //     { name: '\u200B', value: '\u200B' },
        //     { name: 'Inline field title', value: 'Some value here', inline: true },
        //     { name: 'Inline field title', value: 'Some value here', inline: true },
        // )
        .addField(`Lembrete`, `\`\`\`\n${description.content.substring(0, 1000)}\n\`\`\``, false)
        // .setImage('https://i.imgur.com/AfFp7pu.png')
        .setTimestamp()
        .setFooter(author.username, author.displayAvatarURL());

    messageContent = { content: `**Lembrete:**`, embeds: [embedToSend], components: [viewComponents], ephemeral: false, fetchReply: true };
    remindEmbedMessage = await interaction.reply(messageContent)

    const filterMember = i => {
        return i.member.id === interaction.user.id;
    };

    let showReminderMessageInteraction: ButtonInteraction = null
    try {
        showReminderMessageInteraction = await remindEmbedMessage.awaitMessageComponent({ filter: filterMember, componentType: 'BUTTON', time: Configs["ButtonDefaultTimeout"] * 1000 })
        currentInteraction = showReminderMessageInteraction
    } catch (error) {
        console.error(error)

        messageContent = { embeds: [], content: `**😢 Você me deixou no vácuo! 😢**`, components: [] }
        await (interaction as ButtonInteraction).editReply(messageContent)

        currentInteraction = null
    }

    if (showReminderMessageInteraction.customId === "showReminder|cancel") {
        remindEmbedMessage.components[0].components[0].setDisabled(true)
        interaction.editReply({ components: remindEmbedMessage.components });
        tryToDeleteMessage(description)

        messageContent = { embeds: [], content: `**❌ Lembrete cancelado... ❌**`, components: [] }
        await (interaction as ButtonInteraction).editReply(messageContent)
        currentInteraction = null
    } else {
        remindEmbedMessage.components[0].components[1].setDisabled(true)
        interaction.editReply({ components: remindEmbedMessage.components });

        reminderData.materiaID = materia.materiaID;
        reminderData.author = description.author.id;
        reminderData.descriptionURL = description.url;
        reminderData.description = escapeRegExp(description.content);
        if (date)
            reminderData.dueDate = date.format();
        reminderData.type = reminderType;
        reminderData.scope = ReminderScope.Public;
    }

    return { reminderData, lastInteraction: currentInteraction };
}