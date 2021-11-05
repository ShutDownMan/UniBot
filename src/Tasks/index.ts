import Logger from '../Logger'
import Configs from '../config.json'
import Persistence from '../Persistence'
import { ClassStatus, UniClass } from './../Persistence/ClassData'
import Materias from './../../data/materias.json'
import { Materia } from '../Persistence/Materia'
import ExtendedClient from '../Client'
import { sendToTextChannel } from '../Utils'
import { parse, toSeconds, pattern } from 'iso8601-duration';
const log = Logger(Configs.EventsLogLevel, 'tasks.ts')


class Tasks {
    private client: ExtendedClient
    private classReminderTask: NodeJS.Timer

    public constructor(client) {
        this.client = client

        return this
    }

    public async init() {
        console.debug("Tasks init...")
        await this.classReminder()

        await this.initTasks()
    }

    private initTasks() {
        this.classReminderTask = setInterval(() => { this.classReminder() }, Configs.ClassReminderInterval * 1000)
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
                    let classTime = new Date(uniClass.classData.time)
                    let reminderTime = new Date(classTime.getTime() - Configs.ClassReminderTimeInMinutes * 60 * 1000)
                    let finishedClassTime = new Date(classTime.getTime() + toSeconds(parse(uniClass.classData.horario.duracao)) * 1000)


                    if (currentTime >= finishedClassTime) {
                        //^ check if class is finished

                        if (uniClass.classData.status === ClassStatus.UNSTARTED || uniClass.classData.status === ClassStatus.ONGOING) {
                            console.debug("finished? " + JSON.stringify(uniClass.classData))

                            uniClass.classData.status = ClassStatus.DONE
                            await this.client.persistence.upsertClassData(uniClass.classID, uniClass.classData)
                        }
                    }

                    if (currentTime >= classTime && uniClass.classData.status === ClassStatus.UNSTARTED) {
                        //^ check if class is ongoing

                        console.debug("ongoing? " + JSON.stringify(uniClass.classData))

                        uniClass.classData.status = ClassStatus.ONGOING
                        await this.client.persistence.upsertClassData(uniClass.classID, uniClass.classData)
                    }

                    let materia: Materia = Materias[uniClass.classData.materiaID]
                    console.debug(materia.nomeMateria + " passou? " + (currentTime >= reminderTime))
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
            let materia: Materia = Materias[uniClass.classData.materiaID]

            console.debug("SENDING REMINDER TO " + materia.nomeMateria)

            let guild = await this.client.guilds.fetch(process.env.GUILD_ID)
            let mention = await guild.roles.fetch(uniClass.classData.materiaID)

            let message = null

            if (uniClass.classData.status !== ClassStatus.CANCELED) {
                if (uniClass.classData.horario.tipoAula === "Teórica")
                    message = `**Olá ${mention},\nA aula de \`${materia.nomeMateria}\` vai começar!\n<t:${Math.trunc(startTime.getTime() / 1000)}:R>**`

                if (uniClass.classData.horario.tipoAula === "Prática")
                    message = `**Olá,\nA aula de \`${materia.nomeMateria}\` para a turma \`${uniClass.classData.horario.turma}\` vai começar!\n<t:${Math.trunc(startTime.getTime() / 1000)}:R>**`
            } else {
                message = `**Olá ${mention},\nA aula de \`${materia.nomeMateria}\` foi cancelada!**`
            }

            uniClass.classData.reminderSent = true

            await sendToTextChannel(this.client, materia.canalTextoID, message)
            await sendToTextChannel(this.client, materia.canalTextoID, "https://tenor.com/bab2Y.gif")

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

}

export default Tasks
