import { Client, Collection, TextChannel, User } from 'discord.js'
import { Command, Event } from '../Interfaces'
import path from 'path'
import { readdirSync } from 'fs'
import Configs from '../config.json';
import Logger from '../Logger'
import { sendEmbed, Color } from '../Utils'
import Persistence from '../Persistence';
import Tasks from '../Tasks';

console.log(__dirname)

const log = Logger(Configs.ClientLogLevel, 'client.ts')

class ExtendedClient extends Client {
    public commands: Collection<string, Command> = new Collection()
    public aliases: Collection<string, Command> = new Collection()
    public events: Collection<string, Event> = new Collection()

    public persistence: Persistence
    public tasks: Tasks

    constructor(args) {
        super(args);

        this.persistence = new Persistence(this)

        this.tasks = new Tasks(this)
    }

    public async init() {
        /* Commands setup */

        console.info('Loading commands...')
        const commandPath = path.join(__dirname, '..', 'Commands')
        readdirSync(commandPath).forEach((dir) => {
            const commands = readdirSync(`${commandPath}/${dir}`).filter((cmdFile) => cmdFile.endsWith(process.env.IS_DEV_VERSION !== 'true' ? '.js' : '.ts'))

            for (const file of commands) {
                const { command } = require(`${commandPath}/${dir}/${file}`)
                this.commands.set(command.name, command)

                if (command?.aliases.length !== 0) {
                    command.aliases.forEach((alias) => {
                        this.aliases.set(alias, command)
                    })
                }
                console.info(`${command.name} loaded!`)
            }
        })

        /* Events setup */

        console.info('Loading Events...')

        const eventPath = path.join(__dirname, '..', 'Events')
        readdirSync(eventPath).forEach(async (file) => {
            if (file.includes(process.env.IS_DEV_VERSION !== 'true' ? '.js' : '.ts') === true) {
                const { event } = await import(`${eventPath}/${file}`)
                this.events.set(event.name, event)
                this.on(event.name, event.run.bind(null, this))

                console.info(`${event.name} loaded!`)
            }
        })

        this.once('ready', () => {
            console.info(`Bot loaded, ${this.user.tag} is ready to go!`)

            this.user.setActivity(`${global.dataState.prefix}help`, {
                type: 'LISTENING',
            })
        })

        this.login(process.env.BOT_TOKEN)
        
        console.info('Initializing persistence...')
        await this.persistence.init()
    
        console.info('Initializing tasks...')
        await this.tasks.init()
    }

    public async gracefullShutdown(): Promise<void> {
        this.persistence.gracefullShutdown()
        this.tasks.gracefullShutdown()

        if (process.env.IS_DEV_VERSION === 'true') {
            console.info('Client gracefull shutdown...\n')

        }
    }
}

export default ExtendedClient