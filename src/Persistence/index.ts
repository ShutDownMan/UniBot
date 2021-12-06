import Logger from '../Logger'
import Configs from '../config.json'
import Collection from '@discordjs/collection'
import { UniClass, ClassData, ClassStatus } from './Types/ClassData'
import { Client, Pool, QueryResult } from 'node-postgres'
import { Diary, DiaryData } from './Types/DiaryData'
import Materias from '../../data/materias.json'
import makeInterval from 'iso8601-repeating-interval'
import { MateriaData } from './Types/Materia'
import { Moment } from 'moment'
import { toJson, applyMixins } from '../Utils'
import ExtendedClient from '../Client'
import moment from 'moment'
import { Reminder, ReminderData, ReminderScope } from './Types/Reminder'
const log = Logger(Configs.EventsLogLevel, 'persistence.ts')

class NodePostgres {
    public db: Pool = null

    protected async initDB() {
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

}

class DiaryPersistence extends NodePostgres {
    public todaysDiary: Diary = null

    public async fetchTodaysDiary() {
        let today = moment().format().split("T")[0]
        console.debug(today)

        this.todaysDiary = await this.fetchDiary(today)

        return this.todaysDiary
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
                // let givenDate = moment(dateID);
                // console.debug(givenDate)
                // await this.initClassDataByDate(givenDate)

                /// create diary
                diary = await this.upsertDiary(dateID, newDiary)
            } else {
                diary = queryResult.rows[0]
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
        }

        return diary
    }

}

class UniClassPersistence extends NodePostgres {
    public todaysClasses: UniClass[] = null

    public async fetchTodaysClassData() {
        const today = moment().format().split("T")[0]
        this.todaysClasses = await this.fetchClassDataByDiaryID(today)

        return this.todaysClasses
    }

    public async fetchClassDataByDiaryID(diaryID: string) {
        let queryResult: QueryResult = null;

        queryResult = await this.db.query(`
            SELECT * FROM "Class"
            WHERE "classData" ->> 'diaryID' = '${diaryID}'
        `);

        if (queryResult.rowCount > 0)
            return queryResult.rows.map(row => { return toJson(row) })

        return []
    }

    public async fetchClassDataByIds(classesIDs?: number[]) {
        let classesData: UniClass[] = []

        for (const classID of classesIDs) {
            let classData: UniClass = await this.fetchClassData(classID)

            classesData.push(classData)
        }

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
            diaryID: '',
            materiaID: '',
            reminderSent: false,
            startTime: '',
            status: ClassStatus.UNSTARTED,
            horario: null,
        }

        return classData
    }

    public async initUniClassFromMaterias() {
        let classDataList: UniClass[] = []

        /// I FORGOR TO ADD THE DIARIES Entries

        /// pass through each materia
        for (const materiaID of Object.keys(Materias)) {
            let materia: MateriaData = Materias[materiaID]

            /// pass through each horario
            for (const horario of materia.horarios) {
                /// get classes dates
                let classes: Moment[] = makeInterval(horario.inicio).dates()

                for (const classDate of classes) {
                    let tmpClassData = this.createClassData()

                    tmpClassData.materiaID = materiaID
                    tmpClassData.startTime = classDate.format()
                    tmpClassData.horario = horario
                    tmpClassData.diaryID = classDate.format().split("T")[0]

                    let upsertedClassData: UniClass = await this.upsertClassData(0, tmpClassData)

                    classDataList.push(upsertedClassData)
                }
            }

        }

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
}

export class ReminderPersistence extends NodePostgres {

    static createReminderData(): ReminderData {
        let reminderData: ReminderData = {
            type: null,
            createdAt: moment().unix(),
            dueDate: '',
            description: '',
            author: '',
            materiaID: '',
            scope: ReminderScope.Public,
            descriptionURL: '',
            disabled: false
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

    public async fetchRemindersByMateriaID(materiaID: string, reminderScope: ReminderScope, author?: string): Promise<Reminder[]> {
        let reminders: Reminder[] = [];
        let queryResult: QueryResult = null;

        /// AND "reminderData" ->> 'scope' = '${ReminderScope.Personal}'

        console.debug(`
            SELECT * FROM "Reminder"
            WHERE "reminderData" ->> 'materiaID' = '${materiaID}'
            AND "reminderData" ->> 'author' = '${author}'
            AND "reminderData" ->> 'disabled' = 'false'
        `)

        switch (reminderScope) {
            case ReminderScope.Personal:
                queryResult = await this.db.query(`
                    SELECT * FROM "Reminder"
                    WHERE "reminderData" ->> 'materiaID' = '${materiaID}'
                    AND "reminderData" ->> 'author' = '${author}'
                    AND "reminderData" ->> 'disabled' = 'false'
                `);
                break;
            case ReminderScope.Public:
                queryResult = await this.db.query(`
                    SELECT * FROM "Reminder"
                    WHERE "reminderData" ->> 'materiaID' = '${materiaID}'
                    AND (
                        "reminderData" ->> 'scope' = '${ReminderScope.Public}'
                        OR "reminderData" ->> 'author' = '${author}'
                    )
                    AND "reminderData" ->> 'disabled' = 'false'
                `);
                break;
        }

        // console.debug(queryResult)
        reminders = queryResult.rows.map(row => {
            return { reminderID: row.reminderID, reminderData: row.reminderData }
        });

        return reminders;
    }

    public async fetchReminderByID(reminderID: number | string): Promise<Reminder> {
        let queryResult: QueryResult = null;

        queryResult = await this.db.query(`
            SELECT * FROM "Reminder"
            WHERE "reminderID" = ${reminderID}
        `);

        if (queryResult.rowCount > 0)
            return toJson(queryResult.rows[0])

        return null
    }

    public async fetchRemindersByAuthor(author: string, scope: ReminderScope): Promise<Reminder[]> {
        let queryResult: QueryResult = null;

        queryResult = await this.db.query(`
            SELECT * FROM "Reminder"
            WHERE "reminderData" ->> 'author' = '${author}'
        `);

        if (queryResult.rowCount > 0)
            return queryResult.rows.map(row => { return toJson(row) })

        return []
    }

    public async fetchReminders(): Promise<Reminder[]> {
        let queryResult: QueryResult = null;

        queryResult = await this.db.query(`
            SELECT * FROM "Reminder"
            WHERE "reminderData" ->> 'disabled' = 'false'
        `);

        if (queryResult.rowCount > 0)
            return queryResult.rows.map(row => { return toJson(row) })

        return []
    }
}

interface Persistence extends NodePostgres, DiaryPersistence, UniClassPersistence, ReminderPersistence { }

class Persistence {

    protected client: ExtendedClient

    public constructor(client) {

        this.client = client
    }

    public async init() {
        this.initDB()

        const testQueryResult: QueryResult = await this.db.query(`SELECT * FROM "Diary" WHERE "dateID" = '2021-11-03'`);
        // this.initUniClassFromMaterias()
        
        await this.fetchTodaysDiary()

        setInterval(() => { this.fetchTodaysDiary() }, Configs.ClassReminderInterval * 10000)
    }

    public async gracefullShutdown() {
        console.info('Persistence gracefull shutdown...\n')

        this.db.end()
    }
}

applyMixins(Persistence, [NodePostgres, DiaryPersistence, UniClassPersistence, ReminderPersistence])

export default Persistence
