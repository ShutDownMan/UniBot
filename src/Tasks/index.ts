import Logger from '../Logger'
import Configs from '../config.json'
import Persistence from '../Persistence'
import { UniClass } from './../Persistence/ClassData'
const log = Logger(Configs.EventsLogLevel, 'tasks.ts')


class Tasks {
    private persistence: Persistence
    private classReminderTask: NodeJS.Timer

    public constructor(persistence) {
        this.persistence = persistence

        return this
    }

    public async init() {
        log.debug("Tasks init...")
        await Tasks.classReminder(this.persistence)

        // await this.initTasks()
    }

    private initTasks() {
        this.classReminderTask = setInterval(() => {Tasks.classReminder(this.persistence)}, Configs.ClassReminderInterval * 1000)
    }

    static async classReminder(persistence) {
        log.debug("classReminder: ")
        // log.debug(persistence)
        // let now = new Date();
        // let today = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate() + 1));
        // let todaysClassesData = await persistence.fetchClassDataByDate(today)

        let todaysClassesData: UniClass[] = await persistence.fetchTodaysClassData()

        // log.debug(JSON.stringify(todaysClassesData))

        for(const uniClass of todaysClassesData) {
            log.debug(JSON.stringify(uniClass))

        }

        // todaysClassesData.forEach((uniClass: UniClass) => {
            // if(!uniClass.classData.reminderSent) {
            //     let currentTime = new Date()
            //     let reminderTime = new Date(uniClass.classData.time)
            //     reminderTime.setMinutes(-Configs.ClassReminderTimeInMinutes)

            //     if(currentTime >= reminderTime) {
            //         Tasks.sendClassReminder(uniClass.classData)
            //     }
            // }
        // })
    }

    static async sendClassReminder(classData) {

    }

}

export default Tasks
