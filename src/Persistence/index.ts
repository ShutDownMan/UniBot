import Logger from '../Logger'
import Configs from '../config.json'
import Collection from '@discordjs/collection'
import { ClassData, ClassStatus } from './ClassData'
import { Client, Pool, QueryResult } from 'node-postgres'
import { DiaryData } from './DiaryData'
import Materias from '../../data/materias.json'
import makeInterval from 'iso8601-repeating-interval'
import { Materia } from './Materia'
import { Moment } from 'moment'
import { justADate } from '../Utils'
const log = Logger(Configs.EventsLogLevel, 'persistence.ts')

// public classes: Collection<Number, ClassData> = new Collection()
// public diary: Collection<Number, DiaryData> = new Collection()

class Persistence {
    public todaysClassesData: Collection<Number, ClassData> = null
    public todaysDiary: DiaryData

    private db: Pool

    public constructor(configs) {

        return this
    }

    public async init() {
        this.initDB()

        await this.fetchTodaysDiary()
    }

    public async gracefullShutdown() {
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
        // log.debug(today)

        this.todaysDiary = await this.getDiary(today)
    }

    public async getDiary(dateID: string) {
        let diary: DiaryData = null;

        log.debug("FETCHING Diary")
        try {
            const queryResult: QueryResult = await this.db.query(`SELECT * FROM "Diary" WHERE "dateID" = '${dateID}'`);

            // log.debug(queryResult.rows[0])

            if (queryResult.rows.length === 0) {
                diary = await this.upsertDiary(dateID, this.createDiary(dateID))
            } else {
                diary = queryResult.rows[0]
            }
        } catch (error) {
            log.error(error)
        }

        return diary;
    }

    public async upsertDiary(dateID: string, diaryData: DiaryData) {

        log.debug("UPSERTING Diary")
        try {
            const queryResult: QueryResult = await this.db.query(`
                INSERT INTO "Diary"
                ("dateID", "diaryData")
                VALUES ('${dateID}', '${JSON.stringify(diaryData)}')
                ON CONFLICT ("dateID")
                DO UPDATE SET "diaryData" = EXCLUDED."diaryData"
            `);
        } catch (error) {
            log.error(error)
        }

        return diaryData
    }

    public createDiary(dateID: string) {
        let diary: DiaryData = {
            dailyReminderSent: false,
            classesIDs: []
        }

        return diary
    }

    public async fetchTodaysClassData() {
        if (this.todaysClassesData) return this.todaysClassesData

        let classDataList: ClassData[] = []

        /// pass through each materia
        Object.keys(Materias).forEach(materiaID => {
            let materia: Materia = Materias[materiaID]
            let now = new Date();
            let today = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate() + 1));
            // let today = justADate(new Date());

            // today.addDays(1)

            materia.horarios.forEach(horario => {
                /// get classes dates
                let interval: Moment = makeInterval(horario.inicio).firstAfter(today).date

                // log.debug(justADate(interval.toISOString()).toISOString())

                if(today.toISOString() === justADate(interval.toISOString()).toISOString()) {
                    let classData: ClassData = {
                        reminderSent: false,
                        time: interval.toISOString(),
                        status: ClassStatus.UNSTARTED
                    }
                    console.debug(`${classData.toString()}`)

                    classDataList.push(classData)
                }
            })

        })

        // var userEntered = new Date(event.target.valueAsNumber); // valueAsNumber has no time or timezone!


        /// see if there is a class today

        return classDataList
    }

}

export default Persistence
