import { TextChannel, Message, TextBasedChannels, GuildMember } from 'discord.js'
import Logger from '../Logger'
import Configs from '../config.json'
import { ControlRoles, EnrollMessages } from '../Interfaces'
import Materias from '../../data/materias.json'
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

export async function sendEmbed(textChannel: TextChannel | TextBasedChannels, content: Object, ephemeral?: boolean): Promise<void> {
    await textChannel
        .send({
            embeds: [content],
        })
        .then((message: Message) => {
            if (!ephemeral) return;
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

    return await (channel as TextChannel).send(message)
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

export async function tryToDeleteMessage(message: Message) {
    try {
        message.delete()
    } catch (error) {
        console.error(error)
    }
}

function isModerator(member: GuildMember) {
    let controlRoles: string[] = (<any>Object).values(ControlRoles)

    return member.roles.cache.hasAny(...controlRoles)
}

export function capitalize(text: string) {
    return text.charAt(0).toUpperCase() + text.slice(1)
}

export function escapeRegExp(string) {
    return string.replace(/[\\\`]/g, '\\$&'); // $& means the whole matched string
}

export function applyMixins(derivedConstructor: any, baseConstructors: any[]) {
    baseConstructors.forEach(baseConstructor => {
        Object.getOwnPropertyNames(baseConstructor.prototype)
            .forEach(name => {
                Object.defineProperty(derivedConstructor.prototype,
                    name,
                    Object.
                        getOwnPropertyDescriptor(
                            baseConstructor.prototype,
                            name
                        )
                );
            });
    });
}

export async function getMemberCoursesRoles(member: GuildMember) {
    let selectOptions = []

    member.roles.cache.forEach(role => {
        if (role.id in Materias) {
            let materia = Materias[role.id]
            /// create description string
            let materiaProfessoresStr = materia.professores[0].nome

            /// if there's more than 1 professor, apply a reduce
            if ((materia.professores.length > 1))
                materiaProfessoresStr = materia.professores.map(prof => {return prof.nome}).reduce((prev: string, curr: string) => { return `${prev}, ${curr}` })

            selectOptions.push({
                label: materia.nomeMateria,
                description: `${materiaProfessoresStr}`,
                value: `${role.id}`,
            })
        }
    })

    return selectOptions
}
