
export enum ReminderType {
    Note = "anotação",
    Assignment = "exercício",
    Exam = "prova",
    Project = "trabalho",
}

export interface ReminderData {
    type: ReminderType
    dueDate: string
    description: string
    author: string
}

export interface Reminder {
    reminderID: number
    reminderData: ReminderData
}
