import Logger from '../Logger'
import Configs from '../config.json'
import Persistence from '../Persistence'
import { ClassStatus, UniClass } from '../Persistence/Types/ClassData'
import Materias from './../../data/materias.json'
import { Materia, MateriaData } from '../Persistence/Types/Materia'
import ExtendedClient from '../Client'
import { capitalize, sendToTextChannel } from '../Utils'
import { parse, toSeconds, pattern } from 'iso8601-duration';
import { Reminder, ReminderScope } from '../Persistence/Types/Reminder'
import { GuildMember, MessageEmbed } from 'discord.js'
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
        console.debug("=========================")
        console.debug("running classReminder...")
        // console.debug(persistence)
        // let now = new Date();
        // let today = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate() + 1));
        // let todaysClassesData = await persistence.fetchClassDataByDate(today)

        let todaysClassesData: UniClass[] = await this.client.persistence.fetchTodaysClassData()

        // console.debug(JSON.stringify(todaysClassesData))

        for (let uniClass of todaysClassesData) {

            if (uniClass.classData) {
                if (!uniClass.classData.reminderSent) {
                    let currentTime = new Date()
                    let classTime = new Date(uniClass.classData.startTime)
                    let reminderTime = new Date(classTime.getTime() - Configs.ClassReminderTimeInMinutes * 60 * 1000)
                    let finishedClassTime = new Date(classTime.getTime() + toSeconds(parse(uniClass.classData.horario.duracao)) * 1000)


                    if (currentTime >= finishedClassTime) {
                        //^ check if class is finished

                        if (uniClass.classData.status === ClassStatus.UNSTARTED || uniClass.classData.status === ClassStatus.ONGOING) {
                            console.debug("finished? " + JSON.stringify(uniClass.classData))

                            uniClass.classData.status = ClassStatus.FINISHED
                            await this.client.persistence.upsertClassData(uniClass.classID, uniClass.classData)
                        }
                    }

                    if (currentTime >= classTime && uniClass.classData.status === ClassStatus.UNSTARTED) {
                        //^ check if class is ongoing

                        // console.debug("ongoing? " + JSON.stringify(uniClass.classData))

                        uniClass.classData.status = ClassStatus.ONGOING
                        await this.client.persistence.upsertClassData(uniClass.classID, uniClass.classData)
                    }

                    let materia: MateriaData = Materias[uniClass.classData.materiaID]
                    console.debug(materia.nomeMateria + " passou? " + (currentTime >= reminderTime))
                    // console.debug("currentTime:" + JSON.stringify(currentTime))
                    // console.debug("reminderTime:" + JSON.stringify(reminderTime))
                    // console.debug("classTime:" + JSON.stringify(classTime))
                    // console.debug("finishedClassTime:" + JSON.stringify(finishedClassTime))
                    // console.debug(JSON.stringify(toSeconds(parse(uniClass.classData.horario.duracao))))
                    // console.debug("-------------------------")

                    if (currentTime >= reminderTime && (uniClass.classData.status === ClassStatus.UNSTARTED)) {
                        //^ check if time to send reminder

                        console.debug("reminderTime: " + reminderTime)
                        await this.sendClassReminder(uniClass, classTime)
                    }
                }
            }
        }
    }

    private async sendClassReminder(uniClass: UniClass, startTime: Date) {

        try {
            let materia: Materia = { materiaID: uniClass.classData.materiaID, materiaData: Materias[uniClass.classData.materiaID] }

            console.debug("SENDING REMINDER TO " + materia.materiaData.nomeMateria)

            let guild = await this.client.guilds.fetch(process.env.GUILD_ID)
            let mention = await guild.roles.fetch(materia.materiaID)

            let message = null

            if (uniClass.classData.status !== ClassStatus.CANCELED) {
                if (uniClass.classData.horario.tipoAula === "Teórica")
                    message = `**Olá ${mention},\nA aula de \`${materia.materiaData.nomeMateria}\` vai começar!\n<t:${Math.trunc(startTime.getTime() / 1000)}:R>**`

                if (uniClass.classData.horario.tipoAula === "Prática")
                    message = `**Olá,\nA aula de \`${materia.materiaData.nomeMateria}\` para a turma \`${uniClass.classData.horario.turma}\` vai começar!\n<t:${Math.trunc(startTime.getTime() / 1000)}:R>**`
            } else {
                message = `**Olá ${mention},\nA aula de \`${materia.materiaData.nomeMateria}\` foi cancelada!**`
            }

            uniClass.classData.reminderSent = true

            // let remindMessage = await sendToTextChannel(this.client, materia.materiaData.canalTextoID, message)
            // await remindMessage.react("👍")
            // await this.showUpcomingReminders(this.client, materia)
            // await sendToTextChannel(this.client, materia.canalTextoID, "https://tenor.com/bab2Y.gif")

            await this.client.persistence.upsertClassData(uniClass.classID, uniClass.classData)
        } catch (error) {
            console.error(error)
        }
    }

    public async gracefullShutdown(): Promise<void> {
        if (process.env.IS_DEV_VERSION === 'true') {
            console.info('Tasks gracefull shutdown...\n')
        }
    }

    public async showUpcomingReminders(client: ExtendedClient, materia: Materia) {
        let reminders: Reminder[] = await client.persistence.fetchRemindersByMateriaID(materia.materiaID, ReminderScope.Public)
        let guild = await client.guilds.fetch(process.env.GUILD_ID)
        let interactionAuthor = await guild.members.fetch(process.env.BOT_ID)

        let today = moment().startOf('day')
        reminders = reminders.filter((reminder) => { return today < moment(reminder.reminderData.dueDate) })
        reminders = reminders.sort((a, b) => { return (moment(a.reminderData.dueDate) < moment(b.reminderData.dueDate) ? -1 : 1) })

        let embedsToSend: MessageEmbed[] = []
        if (reminders.length > 0) {
            for (let ind = 0; ind < reminders.length / 25 && ind < 10; ++ind) {
                let currentReminders = reminders.splice(ind * 25, 25)

                let embedDesc = ""
                if (materia) {
                    embedDesc = `Lista de lembretes de escopo \`${ReminderScope.Public}\` da matéria de \`${materia.materiaData.nomeMateria}\`.`
                } else {
                    embedDesc = `Lista de lembretes de escopo \`${ReminderScope.Public}\`.`
                }
                let reminderEmbed = new MessageEmbed()
                    .setColor('#4f258a')
                    .setTitle(((ind > 0) ? 'Continuação dos ' : '') + 'Lembretes:')
                    .setDescription(embedDesc)
                    .setTimestamp()
                    .setFooter(interactionAuthor.displayName, interactionAuthor.displayAvatarURL());

                for (let reminder of currentReminders) {
                    let reminderAuthor = await guild.members.fetch(reminder.reminderData.author)
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

        } else {
            let noRemindersEmbed = new MessageEmbed()
                .setColor('#4f258a')
                .setTitle('Lembretes:')
                .setDescription(`**Não há lembretes para esta matéria.**\n\n**OBS:** Você pode adicionar lembretes de tarefas, trabalhos, provas e anotações por meio do comando \`${global.dataState.prefix}lembrete\``)
                .setTimestamp()
                .setFooter(interactionAuthor.displayName, interactionAuthor.displayAvatarURL());

            embedsToSend.push(noRemindersEmbed)
        }

        let messageContent: any = { content: `**\u200b**`, embeds: embedsToSend, components: [], ephemeral: true, fetchReply: true };
        let showRemindersMessage = await sendToTextChannel(this.client, materia.materiaData.canalTextoID, messageContent)
    }

    public async classDiary() {
        let todaysDiary = this.client.persistence.todaysDiary
        if(!todaysDiary || todaysDiary.diaryData.dailyReminderSent) return;

        let guild = await this.client.guilds.fetch(process.env.GUILD_ID)
        let interactionAuthor = await guild.members.fetch(process.env.BOT_ID)
        let todaysClassesData: UniClass[] = await this.client.persistence.fetchTodaysClassData()
        todaysClassesData.sort((a, b) => { return (moment(a.classData.startTime) < moment(b.classData.startTime)) ? -1 : 1})

        let diaryEmbed = new MessageEmbed()
            .setColor('#4f258a')
            .setTitle(`Diário de Aulas <t:${moment().unix()}:D>:`)
            .setDescription(``)
            .setTimestamp()
            .setFooter(interactionAuthor.displayName, interactionAuthor.displayAvatarURL());

        for (let uniClass of todaysClassesData) {
        // debugger;
        let materia: MateriaData = Materias[uniClass.classData.materiaID]
            console.debug(uniClass.classData.startTime)

            if (uniClass.classData && materia) {
                let startTime = moment(uniClass.classData.startTime)

                let fieldName = `${materia.nomeMateria}`
                let fieldDesc = `\
                    Aula ás <t:${startTime.unix()}:t> horas\n\
                `
                diaryEmbed.addField(fieldName, fieldDesc, false)
            }
        }

        sendToTextChannel(this.client, process.env.DIARY_CHANNEL_ID, {content: `\u200b`, embeds: [diaryEmbed]})

        todaysDiary.diaryData.dailyReminderSent = true;
        this.client.persistence.upsertDiary(todaysDiary.dateID, todaysDiary.diaryData)
    }

}

export default Tasks
