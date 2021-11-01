import { TextChannel, Message, TextBasedChannels, GuildMember } from 'discord.js'
import Logger from '../Logger'
import Configs from '../config.json'
import { EnrollMessages } from '../Interfaces'
const log = Logger(Configs.CommandsLogLevel, 'utils.ts')

export const oneHourInMS = 1000 * 60 * 60 * 1

export enum Color {
    info = parseInt(Configs.Colors.info),
    warn = parseInt(Configs.Colors.warn),
    success = parseInt(Configs.Colors.success),
    error = parseInt(Configs.Colors.error),
}

export enum Emojis {
    success = '✅',
    error = '❌',
}

export async function sendEphemeralEmbed(textChannel: TextChannel | TextBasedChannels, content: Object): Promise<void> {
    await textChannel
        .send({
            embeds: [content],
        })
        .then((message: Message) => {
            setTimeout(async () => {
                try {
                    await message.delete()
                } catch (e) {
                    log.debug(`Failed to delete message, this is a discord internal error\n${e.stack}`)
                }
            }, Configs.EphemeralMessageTime * 1000)
        })
        .catch((e) => {
            log.debug(`Failed to send message, this is a discord internal error\n${e.stack}`)
        })
}

export async function safeReact(message: Message, reaction: string): Promise<void> {
    await message.react(reaction).catch((e) => {
        log.debug(`Failed to react, this is a discord internal error\n${e.stack}`)
    })
}

export function isAllowed(member: GuildMember, allowedRoles: string[]) {
    if (member.roles.cache.hasAny(...allowedRoles.map(r => r.toString()))) return true

    return allowedRoles.some(r => r === member.id.toString())
}

export function deleteAfter(message: Message, timeInSeconds: number) {
    setTimeout(async () => {
        try {
            await message.delete()
        } catch (e) {
            log.debug(`Failed to delete message, this is a discord internal error!`)
        }
    }, timeInSeconds * 1000)
}

export function sendToTextChannel(client, channelID, message) {
    client.channels.fetch(channelID).then(channel => {
        if (!channel) return

        (channel as TextChannel).send(message)
    }).catch((error: any) => {
        log.error(error)
    })
}