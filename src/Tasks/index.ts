import Logger from '../Logger'
import Configs from '../config.json'
import Persistence from '../Persistence'
const log = Logger(Configs.EventsLogLevel, 'persistence.ts')


class Tasks {
    private persistence: Persistence
    private classReminderTask: NodeJS.Timer

    public constructor(persistence) {
        this.persistence = persistence

        return this
    }

    public async init() {
        log.debug("init: ")
        await Tasks.classReminder(this.persistence)

        await this.initTasks()
    }

    private initTasks() {
        this.classReminderTask = setInterval(() => {Tasks.classReminder(this.persistence)}, Configs.ClassReminderInterval * 1000)
    }

    static async classReminder(persistence) {
        // log.debug("classReminder: ")
        // log.debug(persistence)
        let todaysClassesData = await persistence.fetchTodaysClassData()

        // todaysClassesData.forEach((classID, classData) => {
        //     if(!classData.reminderSent) {
        //         let currentTime = new Date()
        //         let reminderTime = new Date(classData.time)
        //         reminderTime.setMinutes(-Configs.ClassReminderTimeInMinutes)

        //         if(currentTime >= reminderTime) {
        //             this.sendClassReminder(classData)
        //         }
        //     }
        // })
    }

    private sendClassReminder(classData) {

    }

}

export default Tasks
