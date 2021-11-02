import Logger from '../Logger'
import Configs from '../config.json'
import Persistence from '../Persistence'
const log = Logger(Configs.EventsLogLevel, 'persistence.ts')


class Tasks {
    private persistence: Persistence
    private classReminderTask: NodeJS.Timer

    public constructor(persistence) {
        this.persistence = persistence
    }

    public async init() {
        await this.initTasks()
    }

    private initTasks() {
        this.classReminderTask = setInterval(this.classReminder, Configs.ClassReminderInterval)
    }

    private async classReminder() {
        let todaysClassesData = await this.persistence.fetchTodaysClassData()

        todaysClassesData.forEach(classData => {
            if(!classData.reminderSent) {
                let currentTime = new Date()
                let reminderTime = new Date(classData.time)
                reminderTime.setMinutes(-Configs.ClassReminderTimeInMinutes)

                if(currentTime >= reminderTime) {
                    this.sendClassReminder(classData)
                }
            }
        })
    }

    private sendClassReminder(classData) {

    }

}

export default Tasks
