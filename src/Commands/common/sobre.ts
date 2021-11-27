import { Command } from '../../Interfaces'
import { sendEmbed, Color, deleteAfter } from '../../Utils'
import Logger from '../../Logger'
import Configs from '../../config.json'
const log = Logger(Configs.CommandsLogLevel, 'ping.ts')
import sloc from 'node-sloc'

export const command: Command = {
    name: 'sobre',
    aliases: ['about'],
    description: 'Shows info about the bot.',
    allowedRoles: [process.env.EVERYONE_ROLE_ID.toString()],
    run: async (client, message) => {
        let slocOptions = {
            path: './',
            extensions: ['ts', 'json'],
            ignorePaths: ['node_modules'],
            ignoreDefault: true,
        }
        let slocInfo = await sloc(slocOptions);

        await sendEmbed(message.channel, {
            color: Color.warn,
            author: {
                name: 'Sobre o UniBot.',
            },
            description:
                '```ini\n' +
                'Sou um bot criado e mantido por Jedi. Qualquer bug ou problema pode falar com ele!\nPode usar o comando de ajuda ' +
                `[${global.dataState.prefix}ajuda]  para ver os outros comandos possíveis.` + 
                `\n\nTenho \`${slocInfo.sloc}\` linhas de código e \`${slocInfo.comments}\` linhas de comentários, tudo isso em \`${slocInfo.files}\` arquivos.` +
                '\n\nObs: O template base para o bot foi feito pelo [github.com/costaluu]\n\nO código é aberto pelo repositório [github.com/ShutDownMan/UniBot]' +
                '\n```',
            fields: [
                {
                    name: `Lembretes`,
                    value: 'Aulas: ✅ | Tarefas: ✅ | Trabalhos: ✅ | Provas: ✅',
                    inline: true,
                },
                {
                    name: `Tutoria`,
                    value: 'Agendamento ⚠️ | Lembretes: ⚠️',
                    inline: false,
                },
                {
                    name: `Anotação nas Aulas`,
                    value: 'Anotações públicas ✅ | Anotações privadas: ⚠️',
                    inline: false,
                },
                {
                    name: `Jogos`,
                    value: 'Jogo da Velha: ⚠️ | Chá preto: ⚠️ | Conectar 4: ⚠️',
                    inline: false,
                },
            ],
            timestamp: new Date(),
            footer: {
                text: message.guild.name,
                icon_url: message.guild.iconURL({ dynamic: true }),
            },
        })
        deleteAfter(message, 40)
    },
}