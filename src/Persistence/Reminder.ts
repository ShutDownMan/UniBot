
export enum ReminderType {
    Note = "anotação",
    Assignment = "exercício",
    Exam = "prova",
    Project = "trabalho",
}

export enum ReminderScope {
    Public = "público",
    Personal = "pessoal",
}

export interface ReminderData {
    type: ReminderType
    dueDate: string
    description: string
    descriptionURL: string
    author: string
    scope: ReminderScope
}

export interface Reminder {
    reminderID: number
    reminderData: ReminderData
}
