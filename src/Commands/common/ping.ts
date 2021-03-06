import { Message } from 'discord.js'
import { Command } from '../../Interfaces'
import Logger from '../../Logger'
import Configs from '../../config.json'
const log = Logger(Configs.CommandsLogLevel, 'ping.ts')

export const command: Command = {
    name: 'ping',
    aliases: [],
    description: 'Retorna tempo de resposta.',
    allowedRoles: [process.env.EVERYONE_ROLE_ID.toString()],
    run: async (client, message) => {
        try {
            await message.reply(`🏓 Pong! ${client.ws.ping}ms`).then((message: Message) => {
                setTimeout(async () => {
                    await message.delete()
                }, Configs.EphemeralMessageTime * 1000)
            })
        } catch (e) {
            console.debug(`Failed to send message during ping command, this is a discord internal error \n${e.stack}`)
        }
    },
}