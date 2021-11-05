import { Command, ControlRoles, EnrollMessages } from '../../Interfaces'
import Logger from '../../Logger'
import Configs from '../../config.json'
import { Client, Emoji, Message, MessageActionRow, MessageButton, MessageSelectMenu, TextChannel } from 'discord.js'
import Materias from '../../../data/materias.json'
import ExtendedClient from '../../Client'
import { sendToTextChannel } from '../../Utils'
const log = Logger(Configs.CommandsLogLevel, 'lembrete.ts')

export const command: Command = {
    name: 'lembrete',
    aliases: ['lembretes', 'reminder', 'reminders'],
    description: 'Coloque um lembrete em alguma aula',
    allowedRoles: [process.env.EVERYONE_ROLE_ID.toString()],
    run: async (client, message, args) => {
        console.debug(args)

        if (message.channelId === process.env.BOT_PLAYGROUND_CHANNEL) {
        }

        /// send menu message
        await sendReminderMenu(client, message.channel as TextChannel)
    }
}

async function sendReminderMenu(client: ExtendedClient, channel: TextChannel) {
    /// create select with each year
    let firstRow = new MessageActionRow().addComponents(
        new MessageButton()
            .setCustomId('addReminder|simple')
            .setEmoji("📓")
            .setLabel('Simples')
            .setStyle('PRIMARY'),
        new MessageButton()
            .setCustomId('addReminder|assignment')
            .setEmoji("📑")
            .setLabel("Exercício")
            .setStyle("PRIMARY"),
        new MessageButton()
            .setCustomId('addReminder|exam')
            .setEmoji("📝")
            .setLabel("Prova")
            .setStyle("PRIMARY"),
        new MessageButton()
            .setCustomId('addReminder|project')
            .setEmoji("📖")
            .setLabel("Trabalho")
            .setStyle("PRIMARY"),
    )
    /// create view
    let managementView = {
        content: "**Qual tipo de lembrete deseja adicionar?**",
        components: [firstRow]
    }

    /// send view to channel
    await sendToTextChannel(client, channel.id, managementView)
}