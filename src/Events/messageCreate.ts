import { Event, Command } from '../Interfaces'
import { Message } from 'discord.js'
import Logger from '../Logger'
import { sendEphemeralEmbed, Color, isAllowed } from '../Utils'
import Configs from '../config.json'
const log = Logger(Configs.EventsLogLevel, 'messageCreate.ts')

export const event: Event = {
    name: 'messageCreate',
    run: async (client, message: Message) => {
        // log.debug(message)
        if (message.author.bot === true || !message.guild) return

        if (message.mentions.users.has(client.user.id) === true) {
            await message
                .reply('Olá o/\nPode usar `' + `${global.dataState.prefix}ajuda` + '` para ver a lista de comandos.')
                .then((message: Message) => {
                    setTimeout(async () => {
                        try {
                            await message.delete()
                        } catch (e) {
                            log.debug(`Failed to delete message, this is a discord internal error! \n${e.stack}`)
                        }
                    }, Configs.EphemeralMessageTime * 1000)
                })
                .catch((e) => {
                    log.debug(`Failed to send message, this is a discord internal error! \n${e.stack}`)
                })

            return
        }

        let processedContent = /(^l\.)([^\s]+)\s*((.*|\s*)*)/gm.exec(message.content)

        log.debug(processedContent)

        if (processedContent !== null) {
            if (processedContent[1] !== global.dataState.prefix) return

            const cmd = processedContent[2]
            const args = [processedContent[3]]

            const command = client.commands.get(cmd) || client.aliases.get(cmd)

            // log.debug(cmd, args, command)

            if (command) {
                if (isAllowed(message.member, (command as Command).allowedRoles)) {

                    await (command as Command).run(client, message, args)

                } else {
                    message.reply("Você não tem as permissões necessárias para executar esse comando.")
                }
            } else {
                await sendEphemeralEmbed(message.channel, {
                    color: Color.error,
                    author: {
                        name: `Command not found`,
                    },
                })
            }

            if (message.system === false && message.channelId === global.dataState.threadID) {
                try {
                    await message.delete()
                } catch (e) {
                    log.debug(`Failed to deleted message while play command, this is a discord internal issue`)
                }
            }
        }
    },
}