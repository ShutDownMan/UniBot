
export interface DiaryData {
    dailyReminderSent: boolean
    classesIDs: number[]
}

export interface Diary {
    dateID: string
    diaryData: DiaryData
}
