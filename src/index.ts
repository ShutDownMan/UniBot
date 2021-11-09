import { Intents, User } from 'discord.js'
import Client from './Client'
import Persistence from './Persistence'
import Tasks from './Tasks'
import Logger from './Logger'
import { BotState, ControlRoles, EnrollMessages} from './Interfaces'
import { VoiceChannel, Role, MessageActionRow, MessageButton } from 'discord.js'
import Configs from './config.json'
const log = Logger(Configs.IndexLogLevel, 'index.ts')

require('dotenv').config();

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

    console.info('Initializing bot...')

    /// get client instance
    let client = new Client({
        intents: [Intents.FLAGS.GUILD_VOICE_STATES, Intents.FLAGS.GUILD_MEMBERS, Intents.FLAGS.GUILDS, Intents.FLAGS.GUILD_MESSAGES],
    })

    async function initAll() {
        console.info('Initializing client...')
        await client.init()
        }
    initAll()

    const exitSignals: NodeJS.Signals[] = ['SIGINT', 'SIGTERM', 'SIGQUIT']

    /// on interrupt signals
    exitSignals.map((signal) => {
        process.on(signal, async () => {
            await client.gracefullShutdown()
            if (process.env.IS_DEV_VERSION === 'true') process.exit(ExitStatus.Failure)
        })
    })

    /// on raised exceptions
    process.on('uncaughtException', async (e) => {
        console.error(new Error(`Error: ${e.stack}`))

        /// attempt graceful shutdown
        await client.gracefullShutdown()

        /// if dev version, exit process
        // console.debug(process.env.IS_DEV_VERSION)
        if (process.env.IS_DEV_VERSION === 'true') process.exit(ExitStatus.Failure)
    })

} catch (e) {
    console.error(new Error(`Bot exited due to error \n${e.stack}`))
    process.exit(ExitStatus.Failure)
}
