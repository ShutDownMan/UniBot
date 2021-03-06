import { Command, EnrollMessages } from '../../Interfaces'
import Logger from '../../Logger'
import Configs from '../../config.json'
import { Client, Emoji, GuildMember, GuildMemberRoleManager, Message, MessageActionRow, MessageButton, MessageSelectMenu, Role, TextChannel } from 'discord.js'
import Materias from '../../../data/materias.json'
import ExtendedClient from '../../Client'
import { sendToTextChannel } from '../../Utils'
const log = Logger(Configs.CommandsLogLevel, 'lembrete.ts')

export const command: Command = {
    name: 'lembrete',
    aliases: ['lembretes', 'reminder', 'reminders'],
    description: 'Menu de lembretes das aulas',
    allowedRoles: [process.env.EVERYONE_ROLE_ID.toString()],
    run: async (client, message, args) => {
        // console.debug(args)

        /// send menu message
        await sendReminderMenu(client, message.channel as TextChannel, message.member)
    }
}

async function sendReminderMenu(client: ExtendedClient, channel: TextChannel, member: GuildMember) {
    /// create select with each year
    let firstRow = new MessageActionRow().addComponents(
        new MessageButton()
            .setCustomId('showReminders')
            .setEmoji("📜")
            .setLabel('Mostrar')
            .setStyle('PRIMARY'),
        new MessageButton()
            .setCustomId('addReminder')
            .setEmoji("📝")
            .setLabel("Adicionar")
            .setStyle("SUCCESS"),
        new MessageButton()
            .setCustomId('manageReminders')
            .setEmoji("⚙️")
            .setLabel("Gerenciar")
            .setStyle("SECONDARY"),
    )
    /// create view
    let managementView = {
        content: "**O que deseja fazer com os Lembretes?**",
        components: [firstRow]
    }

    /// send view to channel
    await sendToTextChannel(client, channel.id, managementView)
}