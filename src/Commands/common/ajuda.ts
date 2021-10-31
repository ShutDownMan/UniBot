import { Command } from '../../Interfaces'
import { Color, sendEphemeralEmbed } from '../../Utils'

export const command: Command = {
    name: 'ajuda',
    aliases: ['help'],
    description: 'para mais ajuda contate os tutores no servidor.',
    allowedRoles: [process.env.EVERYONE_ROLE_ID.toString()],
    run: async (client, message, args) => {
        if (args[0] === '') {
            await sendEphemeralEmbed(message.channel, {
                color: Color.info,
                author: {
                    name: 'Ajuda com os comandos',
                },
                description:
                    '```ini\nPode usar ' +
                    `${global.dataState.prefix}ajuda` +
                    ' [comando] para mais ajudas em algum comando especifico.\n\nTemplate: l.[comando/alias] [arg]\n\nObs: em [comando/alias] os colchetes [] não são para serem digitados.\n```',
                fields: [
                    {
                        name: `Comandos Comuns`,
                        value: '`ping`, `ajuda`, `sobre`, `uptime`',
                        inline: false,
                    },
                ],
                timestamp: new Date(),
                footer: {
                    text: message.guild.name,
                    icon_url: message.guild.iconURL({
                        dynamic: true,
                    }),
                },
            })
        } else {
            for (let i = 0; i < args.length; i++) {
                let find = client.commands.get(args[i])

                if (find !== undefined) {
                    let aliasesString = find.aliases?.join(', ')

                    if (aliasesString === '') aliasesString = 'Sem aliases.'

                    await sendEphemeralEmbed(message.channel, {
                        color: Color.info,
                        author: {
                            name: 'Commando ' + find.name[0].toUpperCase() + find.name.slice(1),
                        },
                        description: '```ini\n' + `[Aliases]: ${aliasesString}\n\n[Descrição]: ${find?.description}` + '\n```',
                    })
                } else {
                    find = client.aliases.get(args[i])

                    if (find !== undefined) {
                        let aliasesString = find.aliases?.join(', ')

                        if (aliasesString === '') aliasesString = 'Sem aliases.'

                        await sendEphemeralEmbed(message.channel, {
                            color: Color.info,
                            author: {
                                name: find.name,
                            },
                            description: '```ini\n' + `[Aliases]: ${aliasesString}\n\n[Descrição]: ${find?.description}` + '\n```',
                        })
                    } else {
                        await sendEphemeralEmbed(message.channel, {
                            color: Color.error,
                            author: {
                                name: `Comando não encontrado`,
                            },
                        })
                    }
                }
            }
        }
    },
}