import { Command, ControlRoles, EnrollMessages } from '../../Interfaces'
import Logger from '../../Logger'
import Configs from '../../config.json'
import { MessageActionRow, MessageSelectMenu, TextChannel } from 'discord.js'
const log = Logger(Configs.CommandsLogLevel, 'enroll_setup.ts')

export const command: Command = {
    name: 'enroll_setup',
    aliases: [],
    description: 'Nem pense nisso',
    allowedRoles: (<any>Object).values(ControlRoles),
    run: async (client, message, args) => {

        let row = new MessageActionRow().addComponents(
            new MessageSelectMenu()
                .setCustomId('select')
                .setPlaceholder('Nothing selected')
                .addOptions([
                    {
                        label: 'Select me',
                        description: 'This is a description',
                        value: 'first_option',
                    },
                    {
                        label: 'You can select me too',
                        description: 'This is also a description',
                        value: 'second_option',
                    },
                ]),
        )
        let firstYearEnrollView = {
            content: "**Primeiro Ano**",
            components: [row]
        }

        log.debug("Channels?")
        log.debug(message.member.guild.id)
        log.debug("Channels?")

        message.guild.channels.fetch(process.env.ENROLLMENT_CHANNEL).then(channel => {
            if (!channel) return

            (channel as TextChannel).messages.fetch(EnrollMessages.FirstYearEnrollMessageID).then(m => {
                m.edit(firstYearEnrollView)
            })
        }).catch(error => {
            log.error(error)
        })

    }
}