
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
    createdAt: number
    dueDate: string
    description: string
    descriptionURL: string
    author: string
    materiaID: string
    scope: ReminderScope
    disabled: boolean
}

export interface Reminder {
    reminderID: number
    reminderData: ReminderData
}
