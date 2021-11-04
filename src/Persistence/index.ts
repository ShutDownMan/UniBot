import Logger from '../Logger'
import Configs from '../config.json'
import Collection from '@discordjs/collection'
import { UniClass, ClassData, ClassStatus } from './ClassData'
import { Client, Pool, QueryResult } from 'node-postgres'
import { Diary, DiaryData } from './DiaryData'
import Materias from '../../data/materias.json'
import makeInterval from 'iso8601-repeating-interval'
import { Materia } from './Materia'
import { Moment } from 'moment'
import { justADate, toJson } from '../Utils'
import ExtendedClient from '../Client'
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
    }

    public async gracefullShutdown() {
        log.info('Persistence gracefull shutdown...\n')

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
            log.error(error)
        }
    }

    private async fetchTodaysDiary() {
        let today = (new Date()).toISOString().split("T")[0]
        log.debug(today)

        this.todaysDiary = await this.fetchDiary(today)
        log.debug("this.todaysDiary")
        log.debug(this.todaysDiary)
    }

    public async fetchDiary(dateID: string) {
        let diary: Diary = null;

        log.debug("FETCHING Diary")
        try {
            const queryResult: QueryResult = await this.db.query(`SELECT * FROM "Diary" WHERE "dateID" = '${dateID}'`);
            // log.debug("QUERY STUCK??")
            // log.debug(queryResult)

            if (queryResult.rowCount === 0) {
                let newDiary = this.createDiary()

                /// set classIDs
                let now = new Date();
                let today = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate()));
                this.todaysClasses = await this.fetchClassDataByDate(today)

                newDiary.classesIDs = this.todaysClasses.map(uniClass => {
                    return uniClass.classID
                })

                /// create diary
                diary = await this.upsertDiary(dateID, newDiary)
            } else {
                diary = queryResult.rows[0]
                this.todaysClasses = await this.fetchClassDataByIds(diary.diaryData.classesIDs)
                // log.debug(this.todaysClasses)
                // log.debug(JSON.stringify(diary.diaryData["classesIDs"]))
            }
        } catch (error) {
            log.error(error)
        }

        return diary
    }

    public async upsertDiary(dateID: string, diaryData: DiaryData) {
        let result: Diary = null

        log.debug("UPSERTING Diary")
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
            log.error(error)
        }

        return result
    }

    public createDiary() {
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

        log.debug("FETCHING classData")
        try {
            let queryResult: QueryResult = await this.db.query(`SELECT * FROM "Class" WHERE "classID" = '${classID}'`)

            if (queryResult.rowCount !== 0) {
                classData = toJson(queryResult.rows[0])
                // log.debug(classData)
            }

        } catch (error) {
            log.error(error)
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

        // log.debug("Pq tá vazio o bagulho?")
        // log.debug(JSON.stringify(this.todaysClasses))

        return this.todaysClasses
    }

    public async fetchClassDataByDate(givenDate: Date) {
        let classDataList: UniClass[] = []

        /// pass through each materia
        for (const materiaID of Object.keys(Materias)) {
            let materia: Materia = Materias[materiaID]
            // let today = justADate(new Date());

            /// pass through each horario
            for (const horario of materia.horarios) {
                /// get classes dates
                let interval: Moment = makeInterval(horario.inicio).firstAfter(givenDate).date

                // log.debug(justADate(interval.toISOString()).toISOString())

                /// see if there is a class givenDate
                if (givenDate.toISOString() === justADate(interval.toISOString()).toISOString()) {
                    let tmpClassData = this.createClassData()
                    tmpClassData.materiaID = materiaID
                    tmpClassData.time = interval.toISOString()
                    tmpClassData.horario = horario

                    let upsertedClassData: UniClass = await this.upsertClassData(0, tmpClassData)
                    // log.debug("upsertedClassData:" + JSON.stringify(upsertedClassData))
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
        let result: UniClass = null

        log.debug("UPSERTING Class")
        try {
            let queryResult: QueryResult = null

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
                // log.debug("INSERTED NEW " + JSON.stringify(result))
            } else {
                /// insert updating
                queryResult = await this.db.query(`
                    INSERT INTO "Class"
                    ("classID", "classData")
                    VALUES ('${classID}', '${JSON.stringify(classData)}')
                    ON CONFLICT ("classID")
                    DO UPDATE SET "classData" = EXCLUDED."classData"
                `);
                log.debug("UPSERTED " + classID)
                result = { classID: classID, classData: classData }
            }
        } catch (error) {
            log.error(error)
        }

        return result
    }

}

export default Persistence
