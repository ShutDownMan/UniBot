import { ButtonInteraction, GuildMember, Interaction, Message, MessageActionRow, MessageButton, MessageEmbed, MessageSelectMenu, SelectMenuInteraction } from "discord.js"
import Materias from '../../../data/materias.json'
import Logger from '../../Logger'
import Configs from '../../config.json'
import ExtendedClient from "../../Client"
import { Materia, MateriaData } from "../../Persistence/Types/Materia"
import moment, { Moment } from "moment"
import makeInterval from 'iso8601-repeating-interval'
import * as chrono from 'chrono-node';
import { ReminderData, ReminderScope, ReminderType } from "../../Persistence/Types/Reminder"
import { ReminderPersistence} from "../../Persistence"
import { capitalize, escapeRegExp, getMemberCoursesRoles, tryToDeleteMessage } from "../../Utils"
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

        /// if interaction failed, stop here
        if (!currentInteraction) return;

        currentInteraction = getMateriaFromUserResult.lastInteraction

        /// get materia from materiaID
        materia = { materiaID: getMateriaFromUserResult.materiaID, materiaData: Materias[getMateriaFromUserResult.materiaID] };
    }

    /// get reminder date from user
    let reminderDateResult = await getReminderDate(currentInteraction, materia.materiaID);
    let date: Moment = reminderDateResult.date;
    currentInteraction = reminderDateResult.lastInteraction;

    /// if interaction failed, stop here
    if (!currentInteraction || !reminderDateResult.date) return;

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
    const filter = i => {
        return i.user.id === interaction.user.id
    }

    try {
        /// await for user button interaction
        addReminderMenuInteraction = await reminderMenuMessage.awaitMessageComponent({ filter, componentType: 'BUTTON', time: Configs["ButtonDefaultTimeout"] * 1000 })

        /// get which button was pressed and disable others
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

        /// disable non pressed buttons as to show the user the path taken
        reminderMenuMessage.components[0].components.forEach((component, index) => { component.setDisabled(toDisable[index]) })
        /// edit message reply 
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

    /// create buttons for each reminder type
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
    /// for each materia in Materias
    for (let materiaID of Object.keys(Materias)) {
        let materia: MateriaData = Materias[materiaID]

        /// if given text channel ID is in current materia
        if (channelId === materia.canalTextoID) {
            return { materiaID, materiaData: materia }
        }
    }

    /// nothing found
    return null
}

async function getMateriaFromUser(interaction: ButtonInteraction) {
    let materiaID: string = null
    let selectCourseMessage: Message = await sendCoursesSelect(interaction)
    let selectCourseInteraction: SelectMenuInteraction = null

    /// if message couln't be sent
    if (!selectCourseMessage) return null

    const filter = i => {
        return i.user.id === interaction.user.id;
    };

    /// try to send select message for user to choose
    try {
        /// await for user select menu interaction
        selectCourseInteraction = await selectCourseMessage.awaitMessageComponent({ filter, componentType: 'SELECT_MENU', time: Configs["ButtonDefaultTimeout"] * 1000 })

        /// get materia id from select choice
        materiaID = selectCourseInteraction.values[0]
    } catch (error) {
        console.error(error)

        /// user waited too much to interact
        let messageContent = { content: `**😢 Você me deixou no vácuo! 😢**`, components: [] }
        interaction.editReply(messageContent)

        selectCourseInteraction = null
    }

    /// return results
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

async function getReminderDate(interaction: Interaction, materiaID: string) {
    let reminderDate: Moment = null;
    let currentInteraction: Interaction = null;
    let getDateInteraction: ButtonInteraction = null;

    const filter = i => {
        return i.user.id === interaction.user.id;
    };

    try {
        /// send get reminder date message 
        let reminderMessage: Message = await sendReminderDateMenu(interaction, materiaID)

        try {
            /// await for user button interaction
            getDateInteraction = await reminderMessage.awaitMessageComponent({ filter, componentType: 'BUTTON', time: Configs["ButtonDefaultTimeout"] * 1000 });
            currentInteraction = getDateInteraction;
        } catch (error) {
            console.error(error)

            /// user took too long to respond
            let messageContent = { content: `**😢 Você me deixou no vácuo! 😢**`, components: [] }
            await getDateInteraction.editReply(messageContent)

            currentInteraction = null
        }

        /// if user responded to interaction
        if (currentInteraction) {
            /// fetch user reply
            let userChoice = (getDateInteraction as ButtonInteraction).customId

            /// choose from user choice
            let toDisable = [true, true, true, true]
            switch (userChoice) {
                case "getReminderDate|nextClass":
                    /// get date of next class from materia
                    await (getDateInteraction as ButtonInteraction).deferUpdate();
                    let getNextClassFromMateriaResult = await getNextClassFromMateria(interaction, materiaID)
                    reminderDate = getNextClassFromMateriaResult.date
                    currentInteraction = getNextClassFromMateriaResult.lastInteraction
                    toDisable[0] = false
                    break;
                case "getReminderDate|typeDate":
                    /// get date from user reply
                    await (getDateInteraction as ButtonInteraction).deferUpdate();
                    let getDateFromMessageResult = await getDateFromMessage(interaction)
                    reminderDate = getDateFromMessageResult.date
                    currentInteraction = getDateFromMessageResult.lastInteraction
                    toDisable[1] = false
                    break;
                case "getReminderDate|noDate":
                    /// no reminder date
                    reminderDate = null;
                    toDisable[2] = false
                    break;
                case "getReminderDate|cancel":
                    /// cancel reminder making process
                    await (getDateInteraction as ButtonInteraction).editReply({ content: `Entendi...\nA criação do lembrete foi cancelada.` })
                    toDisable[3] = false
                    break;
            }

            /// disable non clicked buttons
            reminderMessage.components[0].components.forEach((component, index) => { component.setDisabled(toDisable[index]) });
            await (interaction as ButtonInteraction).editReply({ components: reminderMessage.components });
        }

    } catch (error) {
        console.error(error)
    }

    /// return date and last user interaction
    return { date: reminderDate, lastInteraction: currentInteraction }
}

async function sendReminderDateMenu(interaction: Interaction, materiaID: string) {
    let reminderDateView: any = {}

    /// create buttons with reminder date input options
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

    /// reply to interaction
    return await (interaction as ButtonInteraction).reply(reminderDateView) as Message
}

async function getNextClassFromMateria(interaction: Interaction, materiaID: string) {
    let materia: MateriaData = Materias[materiaID]
    let tomorrow = moment().add(1, 'days').startOf('day')
    let nextClass: Moment = null
    let currentInteraction: Interaction = null

    /// loop through each horário in materia
    for (const horario of materia.horarios) {
        /// first after (starting from tomorrow)
        let firstAfterClass: Moment = makeInterval(horario.inicio).firstAfter(tomorrow).date
        /// if next class exists and is earlier than previous next class
        if (!nextClass || firstAfterClass < nextClass) {
            nextClass = firstAfterClass
        }
    }

    /// create confirm buttons dialog message
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

    /// construct confirm dialog message to send
    let messageContent: any = { content: `**O lembrete será: <t:${nextClass.unix()}:R>**`, components: [firstMessageRow], fetchReply: true, ephemeral: true }
    let reminderDateMenuMessage: Message = await (interaction as ButtonInteraction).editReply(messageContent) as Message;

    const filterMember = i => {
        return i.member.id === interaction.user.id;
    };

    let getDateInteraction: ButtonInteraction = null
    try {
        /// await for user button interaction
        getDateInteraction = await reminderDateMenuMessage.awaitMessageComponent({ filter: filterMember, componentType: 'BUTTON', time: Configs["ButtonDefaultTimeout"] * 1000 })
        currentInteraction = getDateInteraction
    } catch (error) {
        console.error(error)

        /// user took to long to interact
        messageContent = { content: `**😢 Você me deixou no vácuo! 😢**`, components: [] }
        await (interaction as ButtonInteraction).editReply(messageContent)

        currentInteraction = null
    }

    /// user cancelled reminder making process
    if (getDateInteraction.customId === "getReminderDate|toCorrect") {
        nextClass = null
        messageContent = { content: `**❌ Lembrete cancelado... ❌**`, components: [] }
        await (interaction as ButtonInteraction).editReply(messageContent)
    }

    /// return next class date and last interaction
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
            return i.member.id === interaction.user.id;
        };

        let reminderDateMenuMessage: Message = await (interaction as ButtonInteraction).editReply(messageContent) as Message;

        let messageResponse = null
        try {
            /// with collection
            let messageCollectionPromise = (interaction as ButtonInteraction).channel.awaitMessages({ filter: filterAuthor, max: 1, errors: ['time'], time: Configs["ButtonDefaultTimeout"] * 1000 })
            let getDateInteractionPromise = reminderDateMenuMessage.awaitMessageComponent({ filter: filterMember, componentType: 'BUTTON', time: Configs["ButtonDefaultTimeout"] * 1000 })
            let racePromise = await Promise.race([messageCollectionPromise, getDateInteractionPromise])

            /// if clicked on cancel button
            if (racePromise instanceof ButtonInteraction) {
                messageContent = { embeds: [], content: `**❌ Lembrete cancelado... ❌**`, components: [] }
                await (interaction as ButtonInteraction).editReply(messageContent)
                return { date: null, lastInteraction: null }
            } else {
                //^ else typed date
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

        if (!parsedDate.isValid()) {
            messageContent = { content: `**Não entendi...\n Por favor, digite a data novamente...**`, components: [secondMessageRow] }
            parsedDate = null
        } else {
            messageContent = { content: `**O lembrete será: <t:${parsedDate.unix()}:F>**`, components: [firstMessageRow] }
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

            if (getDateInteraction.customId === "getReminderDate|toCorrect") {
                parsedDate = null
                getDateInteraction.deferUpdate()
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
                    result.start.assign('hour', 23)
                    result.start.assign('minute', 59)
                    result.start.assign('second', 59)
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

    try {
        let getDateFromMessageResult = await getDescriptionFromMessage(interaction)
        description = getDateFromMessageResult.description
        currentInteraction = getDateFromMessageResult.lastInteraction
    } catch (error) {
        console.error(error)
    }

    return { description, lastInteraction: currentInteraction }
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
    await (interaction as ButtonInteraction).reply(messageContent) as Message;

    /// while description message invalid
    while (!descriptionMessage) {

        await (interaction as ButtonInteraction).editReply(messageContent);

        const filterAuthor = i => {
            return i.author.id === interaction.user.id;
        };

        /// with collection
        let messageCollection = await (interaction as ButtonInteraction).channel.awaitMessages({ filter: filterAuthor, max: 1, errors: ['time'], time: Configs["ButtonDefaultTimeout"] * 1000 })
        let messageResponse = messageCollection.first()

        descriptionMessage = messageResponse

        /// check if message too short
        if (descriptionMessage.content.replace(/ /g, '').length < 3) {
            messageContent = { content: `**Não entendi...\n Digite a mensagem do lembrete novamente...**`, components: [secondMessageRow] }
            descriptionMessage = null
        } else {

            /// escape troublesome characters from message content
            let escapedMessage = escapeRegExp(descriptionMessage.content)
            /// send reminder message preview
            messageContent = { content: `**a mensagem do lembrete ficará assim...**\n\`\`\`\n${escapedMessage}\n\`\`\``, components: [firstMessageRow] }
            let reminderDescriptionMenuMessage: Message = await (interaction as ButtonInteraction).editReply(messageContent) as Message;

            const filterMember = i => {
                return i.member.id === interaction.user.id;
            };

            /// get member user interaction
            let getDescriptionInteraction: ButtonInteraction = null
            try {
                /// await for button interaction
                getDescriptionInteraction = await reminderDescriptionMenuMessage.awaitMessageComponent({ filter: filterMember, componentType: 'BUTTON', time: Configs["ButtonDefaultTimeout"] * 1000 })
                currentInteraction = getDescriptionInteraction
            } catch (error) {
                console.error(error)

                /// user took too long to repond to interaction
                messageContent = { content: `**😢 Você me deixou no vácuo! 😢**`, components: [] }
                await (interaction as ButtonInteraction).editReply(messageContent)

                currentInteraction = null
            }

            /// user choose to fix message
            if (getDescriptionInteraction.customId === "getReminderDescription|toCorrect") {
                /// delete user's sent message
                await tryToDeleteMessage(descriptionMessage)
                getDescriptionInteraction.deferUpdate()

                descriptionMessage = null
                messageContent = { content: `**Digite a mensagem do lembrete novamente...**`, components: [] }
            }
        }
    }

    /// send reminder message preview
    messageContent = { content: `**O lembrete será:**\n\`\`\`${descriptionMessage.content}\`\`\``, components: [] }
    await (interaction as ButtonInteraction).editReply(messageContent) as Message;

    /// return reminder description from user interactions
    return { description: descriptionMessage, lastInteraction: currentInteraction }
}

async function getFinalReminder(interaction: ButtonInteraction, materia: Materia, reminderType: ReminderType, date: Moment, description: Message) {
    let reminderData: ReminderData = ReminderPersistence.createReminderData();
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

    /// construct embed description
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
        .addField(`Lembrete`, `\`\`\`\n${description.content.substring(0, 1000)}\n\`\`\``, false)
        .setTimestamp()
        .setFooter(author.username, author.displayAvatarURL());

    messageContent = { content: `**Lembrete:**`, embeds: [embedToSend], components: [viewComponents], ephemeral: false, fetchReply: true };
    remindEmbedMessage = await interaction.reply(messageContent)

    const filterMember = i => {
        return i.member.id === interaction.user.id;
    };

    let showReminderMessageInteraction: ButtonInteraction = null
    try {
        /// await for member button interaction
        showReminderMessageInteraction = await remindEmbedMessage.awaitMessageComponent({ filter: filterMember, componentType: 'BUTTON', time: Configs["ButtonDefaultTimeout"] * 1000 })
        currentInteraction = showReminderMessageInteraction
    } catch (error) {
        console.error(error)

        /// user took too long to respond to interaction
        messageContent = { embeds: [], content: `**😢 Você me deixou no vácuo! 😢**`, components: [] }
        await (interaction as ButtonInteraction).editReply(messageContent)

        currentInteraction = null
    }

    /// if user cancelled process
    if (showReminderMessageInteraction.customId === "showReminder|cancel") {
        /// disable other button
        remindEmbedMessage.components[0].components[0].setDisabled(true)
        /// delete reminder message
        // tryToDeleteMessage(description)

        /// edit interaction reply
        messageContent = { embeds: [], content: `**❌ Lembrete cancelado... ❌**`, components: [] }
        await (interaction as ButtonInteraction).editReply(messageContent)
        currentInteraction = null
    } else {
        /// disable cancel button
        remindEmbedMessage.components[0].components[1].setDisabled(true)
        await interaction.editReply({ components: remindEmbedMessage.components });

        /// construct reminder in order to return
        reminderData.materiaID = materia.materiaID;
        reminderData.author = description.author.id;
        reminderData.descriptionURL = description.url;
        reminderData.description = escapeRegExp(description.content);
        if (date)
            reminderData.dueDate = date.format();
        reminderData.type = reminderType;
        reminderData.scope = ReminderScope.Public;
    }

    /// return constructed reminder from user interactions
    return { reminderData, lastInteraction: currentInteraction };
}