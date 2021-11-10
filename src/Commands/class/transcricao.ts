import { Command } from '../../Interfaces'
import Logger from '../../Logger'
import Configs from '../../config.json'
import { GuildMember, MessageActionRow, MessageButton, TextChannel } from 'discord.js'
import ExtendedClient from '../../Client'
import { sendToTextChannel } from '../../Utils'
const log = Logger(Configs.CommandsLogLevel, 'transcricao.ts')

export const command: Command = {
    name: 'transcricao',
    aliases: ['transcrição', 'tsc', 'transcribe'],
    description: 'Menu de transcrição das aulas',
    allowedRoles: [process.env.EVERYONE_ROLE_ID.toString()],
    run: async (client, message, args) => {
        // console.debug(args)

        /// send menu message
        await sendTranscriptionMenu(client, message.channel as TextChannel, message.member)
    }
}

async function sendTranscriptionMenu(client: ExtendedClient, channel: TextChannel, member: GuildMember) {
    /// create select with each year
    let firstRow = new MessageActionRow().addComponents(
        new MessageButton()
            .setCustomId('showTranscriptions')
            .setEmoji("📜")
            .setLabel('Mostrar')
            .setStyle('PRIMARY'),
        new MessageButton()
            .setCustomId('addTranscription')
            .setEmoji("📝")
            .setLabel("Adicionar")
            .setStyle("SUCCESS"),
        new MessageButton()
            .setCustomId('manageTranscriptions')
            .setEmoji("⚙️")
            .setLabel("Gerenciar")
            .setStyle("SECONDARY"),
    )
    /// create view
    let managementView = {
        content: "**O que deseja fazer com as Transcrições?**",
        components: [firstRow]
    }

    /// send view to channel
    await sendToTextChannel(client, channel.id, managementView)
}