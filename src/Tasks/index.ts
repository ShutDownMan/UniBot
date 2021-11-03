import Logger from '../Logger'
import Configs from '../config.json'
import Persistence from '../Persistence'
import { UniClass } from './../Persistence/ClassData'
import Materias from './../../data/materias.json'
import { Materia } from '../Persistence/Materia'
import ExtendedClient from '../Client'
import { sendToTextChannel } from '../Utils'
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
        await Tasks.classReminder(this.client, this.persistence)

        await this.initTasks()
    }

    private initTasks() {
        this.classReminderTask = setInterval(() => { Tasks.classReminder(this.client, this.persistence) }, Configs.ClassReminderInterval * 1000)
    }

    static async classReminder(client, persistence) {
        log.debug("classReminder: ")
        // log.debug(persistence)
        // let now = new Date();
        // let today = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate() + 1));
        // let todaysClassesData = await persistence.fetchClassDataByDate(today)

        let todaysClassesData: UniClass[] = await persistence.fetchTodaysClassData()

        // log.debug(JSON.stringify(todaysClassesData))

        for (let uniClass of todaysClassesData) {

            if (uniClass.classData && !uniClass.classData.reminderSent) {
                let currentTime = new Date()
                let reminderTime = new Date(uniClass.classData.time)
                reminderTime.setMinutes(-Configs.ClassReminderTimeInMinutes)

                // Tasks.sendClassReminder(uniClass)
                if (currentTime >= reminderTime) {
                    // log.debug("reminderTime: " + reminderTime)
                    await Tasks.sendClassReminder(client, persistence, uniClass)                    
                }
            }
        }
    }

    static async sendClassReminder(client: ExtendedClient, persistence: Persistence, uniClass: UniClass) {

        try {
            let materia: Materia = Materias[uniClass.classData.materiaID]

            log.debug("SENDING REMINDER TO " + materia.nomeMateria)

            let guild = await client.guilds.fetch(process.env.GUILD_ID)
            let mention = await guild.roles.fetch(uniClass.classData.materiaID)
    
            let message = `**Olá ${mention},\nA aula de \`${materia.nomeMateria}\` vai começar daqui ${Configs.ClassReminderTimeInMinutes} minutos!**`

            uniClass.classData.reminderSent = true
    
            await sendToTextChannel(client, materia.canalTextoID, message)

            await persistence.upsertClassData(uniClass.classID, uniClass.classData)
        } catch (error) {
            log.error(error)
        }
    }

}

export default Tasks
