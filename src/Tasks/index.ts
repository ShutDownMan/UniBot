import Logger from '../Logger'
import Configs from '../config.json'
import { ClassStatus, UniClass } from '../Persistence/Types/ClassData'
import Materias from './../../data/materias.json'
import { Materia, MateriaData } from '../Persistence/Types/Materia'
import ExtendedClient from '../Client'
import { capitalize, sendToTextChannel } from '../Utils'
import { parse, toSeconds } from 'iso8601-duration';
import { Reminder, ReminderScope } from '../Persistence/Types/Reminder'
import { MessageActionRow, MessageButton, MessageEmbed } from 'discord.js'
import moment from 'moment'
const log = Logger(Configs.EventsLogLevel, 'tasks.ts')

class Tasks {
    private client: ExtendedClient
    private classDiaryTask: NodeJS.Timer
    private classReminderTask: NodeJS.Timer

    public constructor(client) {
        this.client = client

        return this
    }

    public async init() {
        console.debug("Tasks init...")
        await this.classDiary()
        await this.classReminder()

        await this.initTasks()
    }

    private initTasks() {
        this.classDiaryTask = setInterval(() => { this.classDiary() }, Configs["ClassDiaryInterval"] * 1000)
        this.classReminderTask = setInterval(() => { this.classReminder() }, Configs["ClassReminderInterval"] * 1000)
    }

    public async classReminder() {
        let todaysClassesData: UniClass[] = await this.client.persistence.fetchTodaysClassData()

        /// for class in todays classes
        for (let uniClass of todaysClassesData) {

            /// if class data is there
            if (uniClass.classData) {
                /// if reminder was not yet sent
                if (!uniClass.classData.reminderSent) {
                    /// get relevant times to check
                    let currentTime = new Date()
                    let classTime = new Date(uniClass.classData.startTime)
                    let reminderTime = new Date(classTime.getTime() - Configs.ClassReminderTimeInMinutes * 60 * 1000)
                    let finishedClassTime = new Date(classTime.getTime() + toSeconds(parse(uniClass.classData.horario.duracao)) * 1000)

                    let classStatus = uniClass.classData.status

                    /// if class is finished
                    if (currentTime >= finishedClassTime && (classStatus === ClassStatus.UNSTARTED || classStatus === ClassStatus.ONGOING)) {
                        console.debug("finished? " + JSON.stringify(uniClass.classData))

                        /// update class status
                        classStatus = ClassStatus.FINISHED
                        /// persist changes
                        await this.client.persistence.upsertClassData(uniClass.classID, uniClass.classData)
                    }

                    /// check if class is ongoing
                    if (currentTime >= classTime && classStatus === ClassStatus.UNSTARTED) {

                        /// update class status
                        classStatus = ClassStatus.ONGOING
                        /// persist changes
                        await this.client.persistence.upsertClassData(uniClass.classID, uniClass.classData)
                    }

                    /// check if time to send reminder
                    if (currentTime >= reminderTime && (classStatus === ClassStatus.UNSTARTED)) {

                        /// update class status
                        console.debug("reminderTime: " + reminderTime)
                        /// persist changes
                        await this.sendClassReminder(uniClass, classTime)
                    }
                }
            }
        }
    }

    private async sendClassReminder(uniClass: UniClass, startTime: Date) {

        try {
            /// get materia info
            let materia: Materia = { materiaID: uniClass.classData.materiaID, materiaData: Materias[uniClass.classData.materiaID] }

            console.debug("SENDING REMINDER TO " + materia.materiaData.nomeMateria)

            /// get guild and mention from client
            let guild = await this.client.guilds.fetch(process.env.GUILD_ID)
            let mention = await guild.roles.fetch(materia.materiaID)

            let message = null

            /// if class is cancelled
            if (uniClass.classData.status !== ClassStatus.CANCELED) {
                /// custom message if pratica ou teórica
                if (uniClass.classData.horario.tipoAula === "Teórica")
                    message = `**Olá ${mention},\nA aula de \`${materia.materiaData.nomeMateria}\` vai começar!\n<t:${Math.trunc(startTime.getTime() / 1000)}:R>**`

                if (uniClass.classData.horario.tipoAula === "Prática")
                    message = `**Olá,\nA aula de \`${materia.materiaData.nomeMateria}\` para a turma \`${uniClass.classData.horario.turma}\` vai começar!\n<t:${Math.trunc(startTime.getTime() / 1000)}:R>**`
            } else {
                message = `**Olá ${mention},\nA aula de \`${materia.materiaData.nomeMateria}\` foi cancelada!**`
            }

            uniClass.classData.reminderSent = true

            /// send message to text channel
            let remindMessage = await sendToTextChannel(this.client, materia.materiaData.canalTextoID, message)
            await remindMessage.react("👍")
            await this.showUpcomingReminders(this.client, materia)
            // await sendToTextChannel(this.client, materia.canalTextoID, "https://tenor.com/bab2Y.gif")

            /// persist changes
            await this.client.persistence.upsertClassData(uniClass.classID, uniClass.classData)
        } catch (error) {
            console.error(error)
        }
    }

    public async gracefullShutdown(): Promise<void> {
        if (process.env.IS_DEV_VERSION === 'true') {
            console.info('Tasks gracefull shutdown...\n')
        }

        clearInterval(this.classDiaryTask)
        clearInterval(this.classReminderTask)
    }

    public async showUpcomingReminders(client: ExtendedClient, materia: Materia) {
        let reminders: Reminder[] = await client.persistence.fetchRemindersByMateriaID(materia.materiaID, ReminderScope.Public)
        let guild = await client.guilds.fetch(process.env.GUILD_ID)
        let interactionAuthor = await guild.members.fetch(process.env.BOT_ID)

        let today = moment().startOf('day')
        /// get only non expired reminders
        reminders = reminders.filter((reminder) => { return today < moment(reminder.reminderData.dueDate) })
        /// sort them by date asc
        reminders = reminders.sort((a, b) => { return (moment(a.reminderData.dueDate) < moment(b.reminderData.dueDate) ? -1 : 1) })

        let embedsToSend: MessageEmbed[] = []
        let componentsToSend: MessageActionRow[] = []
        /// if there are reminders
        if (reminders.length > 0) {
            /// divide reminders in chunks of 25
            for (let ind = 0; ind < reminders.length / 25 && ind < 10; ++ind) {
                let currentReminders = reminders.splice(ind * 25, 25)

                /// create custom desc given available info
                let embedDesc = ""
                if (materia) {
                    embedDesc = `Lista de lembretes de escopo \`${ReminderScope.Public}\` da matéria de \`${materia.materiaData.nomeMateria}\`.`
                } else {
                    embedDesc = `Lista de lembretes de escopo \`${ReminderScope.Public}\`.`
                }
                /// create embed
                let reminderEmbed = new MessageEmbed()
                    .setColor('#4f258a')
                    .setTitle(((ind > 0) ? 'Continuação dos ' : '') + 'Lembretes:')
                    .setDescription(embedDesc)
                    .setTimestamp()
                    .setFooter(interactionAuthor.displayName, interactionAuthor.displayAvatarURL());

                /// create an embed field for each reminder
                for (let reminder of currentReminders) {
                    /// populate fields
                    let reminderAuthor = await guild.members.fetch(reminder.reminderData.author)
                    let reminderTitle = `Lembrete de ${capitalize(reminder.reminderData.type)} de ${reminderAuthor.displayName}`
                    reminderTitle += (reminder.reminderData.dueDate) ? ` <t:${moment(reminder.reminderData.dueDate).unix()}:R>` : ``;
                    let reminderDescStr = reminder.reminderData.description.substring(0, 165).concat((reminder.reminderData.description.length > 150) ? `[...]` : ``)
                    let reminderDesc = `\
                        \`\`\`\n${reminderDescStr}\n\`\`\`\
                        [Mensagem](${reminder.reminderData.descriptionURL} 'Link para a mensagem da anotação')\n\u200b\
                    `

                    /// add to embed
                    reminderEmbed.addField(reminderTitle, reminderDesc, false)
                }

                /// add embed to list of embeds
                embedsToSend.push(reminderEmbed)
            }

        } else {
            //^ no reminders

            /// create a helpful embed
            let noRemindersEmbed = new MessageEmbed()
                .setColor('#4f258a')
                .setTitle('Lembretes:')
                .setDescription(`**Não há lembretes para esta matéria.**\n\n**OBS:** Você pode adicionar lembretes de tarefas, trabalhos, provas e anotações por meio do comando \`${global.dataState.prefix}lembrete\``)
                .setTimestamp()
                .setFooter(interactionAuthor.displayName, interactionAuthor.displayAvatarURL());

            /// add to embed list
            embedsToSend.push(noRemindersEmbed)

            /// create add reminder button
            let addReminderButtonRow = new MessageActionRow().addComponents(
                new MessageButton()
                    .setCustomId('addReminder')
                    .setEmoji("📝")
                    .setLabel("Adicionar Lembrete")
                    .setStyle("SUCCESS")
            )

            /// insert addReminder button to components list
            componentsToSend.push(addReminderButtonRow)
        }

        /// populate message fields and send
        let messageContent: any = { content: `**\u200b**`, embeds: embedsToSend, components: componentsToSend, ephemeral: true, fetchReply: true };
        return await sendToTextChannel(this.client, materia.materiaData.canalTextoID, messageContent)
    }

    public async classDiary() {
        let todaysDiary = await this.client.persistence.fetchTodaysDiary()
        /// if there's no diary for today, exit
        if (!todaysDiary || todaysDiary.diaryData.dailyReminderSent) return;

        let guild = await this.client.guilds.fetch(process.env.GUILD_ID)
        let interactionAuthor = await guild.members.fetch(process.env.BOT_ID)
        let todaysClassesData: UniClass[] = await this.client.persistence.fetchTodaysClassData()

        /// sor classes by time
        todaysClassesData.sort((a, b) => { return (moment(a.classData.startTime) < moment(b.classData.startTime)) ? -1 : 1 })

        /// create class diary embed
        let diaryEmbed = new MessageEmbed()
            .setColor('#4f258a')
            .setTitle(`Diário de Aulas <t:${moment().unix()}:D>:`)
            .setDescription(``)
            .setTimestamp()
            .setFooter(interactionAuthor.displayName, interactionAuthor.displayAvatarURL());

        /// for each class today
        for (let uniClass of todaysClassesData) {
            let materia: MateriaData = Materias[uniClass.classData.materiaID]

            /// if has class data and materia
            if (uniClass.classData && materia) {
                let startTime = moment(uniClass.classData.startTime)

                let fieldName = `${materia.nomeMateria}`
                let fieldDesc = `\
                    Aula ás <t:${startTime.unix()}:t> horas\n\
                `
                /// add class field to embed
                diaryEmbed.addField(fieldName, fieldDesc, false)
            }
        }

        /// send embed to text channel
        sendToTextChannel(this.client, process.env.DIARY_CHANNEL_ID, { content: `\u200b`, embeds: [diaryEmbed] })

        /// set diary as sent
        todaysDiary.diaryData.dailyReminderSent = true;
        /// persist changes
        this.client.persistence.upsertDiary(todaysDiary.dateID, todaysDiary.diaryData)
    }

}

export default Tasks
