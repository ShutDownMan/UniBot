import Logger from '../Logger'
import Configs from '../config.json'
import Collection from '@discordjs/collection'
import { ClassData } from './ClassData'
import { Client, Pool, QueryResult } from 'node-postgres'
import { DiaryData } from './DiaryData'
const log = Logger(Configs.EventsLogLevel, 'persistence.ts')

// public classes: Collection<Number, ClassData> = new Collection()
// public diary: Collection<Number, DiaryData> = new Collection()

class Persistence {
    public todaysClassesData: Collection<Number, ClassData> = new Collection()
    public todaysDiary: DiaryData

    private db: Pool

    public constructor(configs) {

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
        log.debug(today)

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
            dailyReminderSent: false
        }

        return diary
    }

    public async fetchTodaysClassData() {
        return []
    }

}

export default Persistence
