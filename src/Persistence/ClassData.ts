
export enum ClassStatus {
    UNSTARTED,
    ONGOING,
    DONE,
    CANCELED
}

export interface ClassData {
    materiaID: string
    reminderSent: boolean
    time: string
    status: ClassStatus
}

export interface UniClass {
    classID: number
    classData: ClassData
}