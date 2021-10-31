import { Event } from '../Interfaces'
import { Message, VoiceState, VoiceChannel, TextChannel, User } from 'discord.js'
import Logger from '../Logger'
import Configs from '../config.json'
const log = Logger(Configs.EventsLogLevel, 'voiceStateUpdate.ts')

export const event: Event = {
    name: 'voiceStateUpdate',
    run: async (client, oldChannel: VoiceState, newChannel: VoiceState) => {
    }
}