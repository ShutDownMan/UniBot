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
    private persistence: Persistence
    private client: ExtendedClient
    private classReminderTask: NodeJS.Timer

    public constructor(client, persistence) {
        this.persistence = persistence
        this.client = client

        return this
    }

    public async init() {
        log.debug("Tasks init...")
        await this.classReminder()

        await this.initTasks()
    }

    private initTasks() {
        this.classReminderTask = setInterval(() => { this.classReminder() }, Configs.ClassReminderInterval * 1000)
    }

    public async classReminder() {
        log.debug("running classReminder...")
        // log.debug(persistence)
        // let now = new Date();
        // let today = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate() + 1));
        // let todaysClassesData = await persistence.fetchClassDataByDate(today)

        let todaysClassesData: UniClass[] = await this.persistence.fetchTodaysClassData()

        // log.debug(JSON.stringify(todaysClassesData))

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
                            log.debug("finished? " + JSON.stringify(uniClass.classData))

                            uniClass.classData.status = ClassStatus.DONE
                            await this.persistence.upsertClassData(uniClass.classID, uniClass.classData)
                        }
                    }

                    if (currentTime >= classTime && uniClass.classData.status === ClassStatus.UNSTARTED) {
                        //^ check if class is ongoing

                        log.debug("ongoing? " + JSON.stringify(uniClass.classData))

                        uniClass.classData.status = ClassStatus.ONGOING
                        await this.persistence.upsertClassData(uniClass.classID, uniClass.classData)
                    }

                    let materia: Materia = Materias[uniClass.classData.materiaID]
                    log.debug(materia.nomeMateria + " passou? " + (currentTime >= reminderTime))
                    // log.debug("reminderTime:" + JSON.stringify(reminderTime))
                    log.debug("classTime:" + JSON.stringify(classTime))
                    log.debug("finishedClassTime:" + JSON.stringify(finishedClassTime))
                    log.debug(JSON.stringify(toSeconds(parse(uniClass.classData.horario.duracao))))
                    log.debug("-------------------------")

                    if (currentTime >= reminderTime && (uniClass.classData.status === ClassStatus.UNSTARTED || uniClass.classData.status === ClassStatus.ONGOING)) {
                        //^ check if time to send reminder

                        log.debug("reminderTime: " + reminderTime)
                        await this.sendClassReminder(uniClass, classTime)
                    }
                }
            }
        }
    }


    private async sendClassReminder(uniClass: UniClass, startTime: Date) {

        try {
            let materia: Materia = Materias[uniClass.classData.materiaID]

            log.debug("SENDING REMINDER TO " + materia.nomeMateria)

            let guild = await this.client.guilds.fetch(process.env.GUILD_ID)
            let mention = await guild.roles.fetch(uniClass.classData.materiaID)

            let message = null

            if (uniClass.classData.status !== ClassStatus.CANCELED) {
                if (uniClass.classData.horario.tipoAula === "Teórica")
                    message = `**Olá ${mention},\nA aula de \`${materia.nomeMateria}\` vai começar <t:${Math.trunc(startTime.getTime() / 1000)}:R>!**`

                if (uniClass.classData.horario.tipoAula === "Prática")
                    message = `**Olá,\nA aula de \`${materia.nomeMateria}\` para a turma \`${uniClass.classData.horario.turma}\` vai começar daqui ${Configs.ClassReminderTimeInMinutes} minutos!**`
            } else {
                message = `**Olá ${mention},\nA aula de \`${materia.nomeMateria}\` foi cancelada!**`
            }

            uniClass.classData.reminderSent = true

            // await sendToTextChannel(this.client, materia.canalTextoID, message)

            await this.persistence.upsertClassData(uniClass.classID, uniClass.classData)
        } catch (error) {
            log.error(error)
        }
    }

}

export default Tasks
