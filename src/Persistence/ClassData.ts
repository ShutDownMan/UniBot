import { Horario } from "./Horario";

export enum ClassStatus {
    UNSTARTED,
    ONGOING,
    FINISHED,
    CANCELED,
    REMOVED
}

export interface ClassData {
    materiaID: string
    reminderSent: boolean
    startTime: string
    status: ClassStatus
    horario: Horario
}

export interface UniClass {
    classID: number
    classData: ClassData
}