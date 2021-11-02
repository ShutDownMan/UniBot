require('events').EventEmitter.defaultMaxListeners = 30
import { Intents, User } from 'discord.js'
import Client from './Client'
import Persistence from './Persistence'
import Tasks from './Tasks'
import Logger from './Logger'
import { BotState, ControlRoles, EnrollMessages} from './Interfaces'
import { VoiceChannel, Role, MessageActionRow, MessageButton } from 'discord.js'
import Configs from './config.json'
const log = Logger(Configs.IndexLogLevel, 'index.ts')

let dataState: BotState = {
    controlRoles: [ControlRoles.Admin, ControlRoles.Dev, ControlRoles.Moderator],
    prefix: process.argv[2] /* Bot Prefix */,
    enrollMessages: (<any>Object).values(EnrollMessages),
    clear() {},
}

global.dataState = dataState

enum ExitStatus {
    Failure = 1,
    Success = 0,
}

try {
    console.clear()

    log.info('Initializing bot...')

    /// get client instance
    let client = new Client({
        intents: [Intents.FLAGS.GUILD_VOICE_STATES, Intents.FLAGS.GUILD_MEMBERS, Intents.FLAGS.GUILDS, Intents.FLAGS.GUILD_MESSAGES],
    })

    log.info('Initializing client...')
    client.init()


    let persistence = new Persistence({})

    log.info('Initializing persistence...')
    persistence.init()

    let tasks = new Tasks(persistence)
    log.info('Initializing tasks...')
    tasks.init()

    const exitSignals: NodeJS.Signals[] = ['SIGINT', 'SIGTERM', 'SIGQUIT']

    /// on interrupt signals
    exitSignals.map((signal) => {
        process.on(signal, async () => {
            await client.gracefullShutdown()
            await persistence.gracefullShutdown()
            if (process.env.IS_DEV_VERSION === 'true') process.exit(ExitStatus.Failure)
        })
    })

    /// on raised exceptions
    process.on('uncaughtException', async (e) => {
        log.fatal(new Error(`Error: ${e.stack}`))

        /// attempt graceful shutdown
        await client.gracefullShutdown()
        await persistence.gracefullShutdown()

        /// if dev version, exit process
        // log.debug(process.env.IS_DEV_VERSION)
        if (process.env.IS_DEV_VERSION) process.exit(ExitStatus.Failure)
    })

} catch (e) {
    log.error(new Error(`Bot exited due to error \n${e.stack}`))
    process.exit(ExitStatus.Failure)
}

