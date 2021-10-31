import { Client, Collection, TextChannel, User } from 'discord.js'
import { Command, Event } from '../Interfaces'
import path from 'path'
import { readdirSync } from 'fs'
import Configs from '../config.json';
import Logger from '../Logger'
import { sendEphemeralEmbed, Color } from '../Utils'

console.log(__dirname)

const log = Logger(Configs.ClientLogLevel, 'client.ts')

class ExtendedClient extends Client {
    public commands: Collection<string, Command> = new Collection()
    public aliases: Collection<string, Command> = new Collection()
    public events: Collection<string, Event> = new Collection()

    constructor(args) {
        super(args);
    }

    public async init() {
        /* Commands setup */

        log.info('Loading commands...')
        const commandPath = path.join(__dirname, '..', 'Commands')
        readdirSync(commandPath).forEach((dir) => {
            const commands = readdirSync(`${commandPath}/${dir}`).filter((cmdFile) => cmdFile.endsWith(process.env.IS_DEV_VERSION === 'false' ? '.js' : '.ts'))

            for (const file of commands) {
                const { command } = require(`${commandPath}/${dir}/${file}`)
                this.commands.set(command.name, command)

                if (command?.aliases.length !== 0) {
                    command.aliases.forEach((alias) => {
                        this.aliases.set(alias, command)
                    })
                }
                log.info(`${command.name} loaded!`)
            }
        })

        /* Events setup */

        log.info('Loading events...')

        const eventPath = path.join(__dirname, '..', 'Events')
        readdirSync(eventPath).forEach(async (file) => {
            if (file.includes(process.env.IS_DEV_VERSION === 'false' ? '.js' : '.ts') === true) {
                const { event } = await import(`${eventPath}/${file}`)
                this.events.set(event.name, event)
                this.on(event.name, event.run.bind(null, this))

                log.info(`${event.name} loaded!`)
            }
        })

        this.once('ready', () => {
            log.info(`Bot loaded, ${this.user.tag} is ready to go!`)

            this.user.setActivity(`${global.dataState.prefix}help`, {
                type: 'LISTENING',
            })
        })

        this.login(process.env.BOT_TOKEN)
    }

    public async gracefullShutdown(): Promise<void> {
        if (process.env.IS_DEV_VERSION === 'true') {
            log.info('Gracefull shutdown...\n')

        }
    }
}

export default ExtendedClient