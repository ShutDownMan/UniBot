import Logger from '../Logger'
import Configs from '../config.json'
import Collection from '@discordjs/collection'
import { UniClass, ClassData, ClassStatus } from './ClassData'
import { Client, Pool, QueryResult } from 'node-postgres'
import { Diary, DiaryData } from './DiaryData'
import Materias from '../../data/materias.json'
import makeInterval from 'iso8601-repeating-interval'
import { MateriaData } from './Materia'
import { Moment } from 'moment'
import { toJson } from '../Utils'
import ExtendedClient from '../Client'
import moment from 'moment'
import { Reminder, ReminderData, ReminderScope } from './Reminder'
const log = Logger(Configs.EventsLogLevel, 'persistence.ts')

// public classes: Collection<Number, ClassData> = new Collection()
// public diary: Collection<Number, DiaryData> = new Collection()

class Persistence {
    public todaysDiary: Diary = null
    public todaysClasses: UniClass[] = null

    private client: ExtendedClient
    private db: Pool

    public constructor(client) {
        this.client = client
    }

    public async init() {
        this.initDB()

        const queryResult: QueryResult = await this.db.query(`SELECT * FROM "Diary" WHERE "dateID" = '2021-11-03'`);

        await this.fetchTodaysDiary()

        setInterval(() => { this.fetchTodaysDiary() }, Configs.ClassReminderInterval * 10000)
    }

    public async gracefullShutdown() {
        console.info('Persistence gracefull shutdown...\n')

        this.db.end()
    }

    private async initDB() {
        try {
            this.db = new Pool({
                user: process.env.PGUSER,
                host: process.env.PGHOST,
                database: process.env.PGDATABASE,
                password: process.env.PGPASSWORD,
                port: Number(process.env.PGPORT),
            })
        } catch (error) {
            console.error(error)
        }
    }

    private async fetchTodaysDiary() {
        let today = moment().format().split("T")[0]
        console.debug(today)

        this.todaysDiary = await this.fetchDiary(today)
        console.debug("this.todaysDiary")
        console.debug(this.todaysDiary)
        this.todaysClasses = await this.fetchClassDataByIds(this.todaysDiary.diaryData.classesIDs)
    }

    public async fetchDiary(dateID: string) {
        let diary: Diary = null;

        console.debug("FETCHING Diary")
        try {
            const queryResult: QueryResult = await this.db.query(`SELECT * FROM "Diary" WHERE "dateID" = '${dateID}'`);
            // console.debug("QUERY STUCK??")
            // console.debug(queryResult)

            if (queryResult.rowCount === 0) {
                let newDiary = this.createDiaryData()

                /// set classIDs
                let givenDate = moment(dateID);
                console.debug(givenDate)
                let dayClasses = await this.createClassDataByDate(givenDate)

                newDiary.classesIDs = dayClasses.map(uniClass => {
                    return uniClass.classID
                })

                /// create diary
                diary = await this.upsertDiary(dateID, newDiary)
            } else {
                diary = queryResult.rows[0]
                // this.todaysClasses = await this.fetchClassDataByIds(diary.diaryData.classesIDs)
                // console.debug(this.todaysClasses)
                // console.debug(JSON.stringify(diary.diaryData["classesIDs"]))
            }
        } catch (error) {
            console.error(error)
        }

        return diary
    }

    public async upsertDiary(dateID: string, diaryData: DiaryData) {
        let result: Diary = null

        console.debug("UPSERTING Diary")
        try {
            const queryResult: QueryResult = await this.db.query(`
                INSERT INTO "Diary"
                ("dateID", "diaryData")
                VALUES ('${dateID}', '${JSON.stringify(diaryData)}')
                ON CONFLICT ("dateID")
                DO UPDATE SET "diaryData" = EXCLUDED."diaryData"
            `);

            result = { dateID: dateID, diaryData: diaryData }
        } catch (error) {
            console.error(error)
        }

        return result
    }

    public createDiaryData() {
        let diary: DiaryData = {
            dailyReminderSent: false,
            classesIDs: []
        }

        return diary
    }

    public async fetchClassDataByIds(classesIDs?: number[]) {
        let classesData: UniClass[] = []

        for (const classID of classesIDs) {
            let classData: UniClass = await this.fetchClassData(classID)

            classesData.push(classData)
        }
        // await Promise.all(classesIDs.map(async (classID) => {
        // }))

        return classesData
    }

    public async fetchClassData(classID: number) {
        let classData: UniClass = null;

        console.debug("FETCHING classData")
        try {
            let queryResult: QueryResult = await this.db.query(`SELECT * FROM "Class" WHERE "classID" = '${classID}'`)

            if (queryResult.rowCount !== 0) {
                classData = toJson(queryResult.rows[0])
                // console.debug(classData)
            }

        } catch (error) {
            console.error(error)
        }

        return classData
    }

    public createClassData() {
        let classData: ClassData = {
            materiaID: '',
            reminderSent: false,
            time: '',
            status: ClassStatus.UNSTARTED,
            horario: null
        }

        return classData
    }

    public async fetchTodaysClassData() {
        if (!this.todaysClasses) this.todaysClasses = await this.fetchClassDataByIds(this.todaysDiary.diaryData.classesIDs)

        // console.debug("Pq tá vazio o bagulho?")
        // console.debug(JSON.stringify(this.todaysClasses))

        return this.todaysClasses
    }

    public async createClassDataByDate(givenDate: Moment) {
        let classDataList: UniClass[] = []

        /// pass through each materia
        for (const materiaID of Object.keys(Materias)) {
            let materia: MateriaData = Materias[materiaID]

            /// pass through each horario
            for (const horario of materia.horarios) {
                /// get classes dates
                let interval: Moment = makeInterval(horario.inicio).firstAfter(givenDate.startOf('day')).date


                // console.debug(givenDate.startOf('day').format())
                // console.debug(interval.startOf('day').format())

                /// see if there is a class givenDate
                if (givenDate.startOf('day').format() === interval.startOf('day').format()) {
                    let tmpClassData = this.createClassData()
                    tmpClassData.materiaID = materiaID
                    tmpClassData.time = interval.startOf('day').format()
                    tmpClassData.horario = horario

                    let upsertedClassData: UniClass = await this.upsertClassData(0, tmpClassData)
                    // console.debug("upsertedClassData:" + JSON.stringify(upsertedClassData))
                    // console.debug(`${classData.toString()}`)

                    classDataList.push(upsertedClassData)
                }

            }

            // await Promise.all(materia.horarios.map(async horario => {
            // }))
        }

        // await Promise.all(Object.keys(Materias).map(async materiaID => {
        // }))

        return classDataList
    }

    public async upsertClassData(classID: number, classData: ClassData) {
        let result: UniClass = null;

        console.debug("UPSERTING Class");
        try {
            let queryResult: QueryResult = null;

            /// if no id specified
            if (classID === 0) {
                /// just simple insert returning id
                queryResult = await this.db.query(`
                    INSERT INTO "Class"
                    ("classData")
                    VALUES ('${JSON.stringify(classData)}')
                    RETURNING ("classID"::INTEGER)
                `);
                result = { classID: queryResult.rows[0].classID, classData: classData }
                // console.debug("INSERTED NEW " + JSON.stringify(result))
            } else {
                /// insert updating
                queryResult = await this.db.query(`
                    INSERT INTO "Class"
                    ("classID", "classData")
                    VALUES ('${classID}', '${JSON.stringify(classData)}')
                    ON CONFLICT ("classID")
                    DO UPDATE SET "classData" = EXCLUDED."classData"
                `);
                console.debug("UPSERTED " + classID);
                result = { classID: classID, classData: classData };
            }
        } catch (error) {
            console.error(error);
        }

        return result;
    }

    static createReminderData(): ReminderData {
        let reminderData: ReminderData = {
            type: null,
            dueDate: '',
            description: '',
            author: '',
            scope: ReminderScope.Public,
            descriptionURL: ''
        }

        return reminderData;
    }

    public async upsertReminder(reminderID: number, reminderData: ReminderData) {
        let result: Reminder = null;

        console.debug("UPSERTING Reminder");
        try {
            let queryResult: QueryResult = null;

            /// if no id specified
            if (reminderID === 0) {
                /// just simple insert returning id
                queryResult = await this.db.query(`
                    INSERT INTO "Reminder"
                    ("reminderData")
                    VALUES ('${JSON.stringify(reminderData)}')
                    RETURNING ("reminderID"::INTEGER)
                `);
                result = { reminderID: queryResult.rows[0].reminderID, reminderData: reminderData }
                // console.debug("INSERTED NEW " + JSON.stringify(result))
            } else {
                /// insert updating
                queryResult = await this.db.query(`
                    INSERT INTO "Reminder"
                    ("reminderID", "reminderData")
                    VALUES ('${reminderID}', '${JSON.stringify(reminderData)}')
                    ON CONFLICT ("reminderID")
                    DO UPDATE SET "reminderData" = EXCLUDED."reminderData"
                `);
                console.debug("UPSERTED " + reminderID);
                result = { reminderID, reminderData };
            }
        } catch (error) {
            console.error(error);
        }

        return result;
    }

    public async fetchRemindersByMateriaID(materiaID: string, author: string, reminderScope: ReminderScope): Promise<Reminder[]> {
        let reminders: Reminder[] = [];
        let queryResult: QueryResult = null;

        switch (reminderScope) {
            case ReminderScope.Personal:
                queryResult = await this.db.query(`
                    SELECT * FROM "Reminder"
                    WHERE reminderData ->> 'materiaID' = ${materiaID}
                    AND reminderData ->> 'scope' = ${ReminderScope.Personal}
                    AND reminderData ->> 'author' = ${author};
                `);
                break;
            case ReminderScope.Public:
                queryResult = await this.db.query(`
                    SELECT * FROM "Reminder"
                    WHERE reminderData ->> 'materiaID' = ${materiaID}
                    AND reminderData ->> 'scope' = ${ReminderScope.Public}
                `);
                break;
        }
        reminders = queryResult.rows.map(row => {
            return {reminderID: row.reminderID, reminderData: row.reminderData}
        });

        return reminders;
    }
    

}

export default Persistence
