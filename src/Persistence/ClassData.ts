
export enum ClassStatus {
    UNSTARTED,
    ONGOING,
    DONE,
    CANCELED
}

export interface ClassData {
    reminderSent: boolean
    time: string
    status: ClassStatus
}