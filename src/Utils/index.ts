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
                    console.debug(`Failed to delete message, this is a discord internal error\n${e.stack}`)
                }
            }, Configs.EphemeralMessageTime * 1000)
        })
        .catch((e) => {
            console.debug(`Failed to send message, this is a discord internal error\n${e.stack}`)
        })
}

export async function safeReact(message: Message, reaction: string): Promise<void> {
    await message.react(reaction).catch((e) => {
        console.debug(`Failed to react, this is a discord internal error\n${e.stack}`)
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
            console.debug(`Failed to delete message, this is a discord internal error!`)
        }
    }, timeInSeconds * 1000)
}

export async function sendToTextChannel(client, channelID, message) {
    let channel = await client.channels.fetch(channelID)

    if (!channel) return

    (channel as TextChannel).send(message)
}

export function justADate(initDate) {
    var utcMidnightDateObj = null
    // if no date supplied, use Now.
    if (!initDate)
        initDate = new Date();

    // if initDate specifies a timezone offset, or is already UTC, just keep the date part, reflecting the date _in that timezone_
    if (typeof initDate === "string" && initDate.match(/((\+|-)\d{2}:\d{2}|Z)$/gm)) {
        utcMidnightDateObj = new Date(initDate.substring(0, 10) + 'T00:00:00Z');
    } else {
        // if init date is not already a date object, feed it to the date constructor.
        if (!(initDate instanceof Date))
            initDate = new Date(initDate);
        // Vital Step! Strip time part. Create UTC midnight dateObj according to local timezone.
        utcMidnightDateObj = new Date(Date.UTC(initDate.getFullYear(), initDate.getMonth(), initDate.getDate()));
    }

    return {
        toISOString: () => utcMidnightDateObj.toISOString(),
        getUTCDate: () => utcMidnightDateObj.getUTCDate(),
        getUTCDay: () => utcMidnightDateObj.getUTCDay(),
        getUTCFullYear: () => utcMidnightDateObj.getUTCFullYear(),
        getUTCMonth: () => utcMidnightDateObj.getUTCMonth(),
        setUTCDate: (arg) => utcMidnightDateObj.setUTCDate(arg),
        setUTCFullYear: (arg) => utcMidnightDateObj.setUTCFullYear(arg),
        setUTCMonth: (arg) => utcMidnightDateObj.setUTCMonth(arg),
        addDays: (days) => {
            utcMidnightDateObj.setUTCDate(utcMidnightDateObj.getUTCDate + days)
        },
        toString: () => utcMidnightDateObj.toString(),
        toLocaleDateString: (locale, options) => {
            options = options || {};
            options.timeZone = "UTC";
            locale = locale || "en-EN";
            return utcMidnightDateObj.toLocaleDateString(locale, options)
        }
    }
}

export function toJson(data) {
    if (data !== undefined) {
        let intCount = 0, repCount = 0;
        const json = JSON.stringify(data, (_, v) => {
            if (typeof v === 'bigint') {
                intCount++;
                return `${v}#bigint`;
            }
            return v;
        });
        const res = json.replace(/"(-?\d+)#bigint"/g, (_, a) => {
            repCount++;
            return a;
        });
        if (repCount > intCount) {
            // You have a string somewhere that looks like "123#bigint";
            throw new Error(`BigInt serialization conflict with a string value.`);
        }
        return JSON.parse(res);
    }
}

// BigInt.prototype['toJSON'] = function() { return toJson(this) }