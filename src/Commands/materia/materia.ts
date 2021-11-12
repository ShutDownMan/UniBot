import { Command } from '../../Interfaces'
import Logger from '../../Logger'
import Configs from '../../config.json'
import { ButtonInteraction, GuildMember, Message, MessageActionRow, MessageButton, MessageEmbed, MessageSelectMenu, SelectMenuInteraction, TextBasedChannels, TextChannel } from 'discord.js'
import Materias from '../../../data/materias.json'
import ExtendedClient from '../../Client'
import { sendToTextChannel } from '../../Utils'
import { Materia, MateriaData } from '../../Persistence/Types/Materia'
import { Professor } from '../../Persistence/Types/Professor'
const log = Logger(Configs.CommandsLogLevel, 'materia.ts')

export const command: Command = {
    name: 'materia',
    aliases: ['materias', 'course', 'mat'],
    description: 'Informações da matéria',
    allowedRoles: [process.env.EVERYONE_ROLE_ID.toString()],
    run: async (client, message, args) => {
        let materia: Materia = getMateriaFromTextChannel(message.channelId);

        /// get from which materia user wants to add reminder to
        if (!materia) {
            materia = await getMateriaFromUser(message.member, message.channel);

            if (!materia) return;
        }

        /// send materia information message
        await sendMateriaInfoMessage(materia, message.member, message.channel)
    }
}

function getMateriaFromTextChannel(channelId: string): Materia {
    for (let materiaID of Object.keys(Materias)) {
        let materia: MateriaData = Materias[materiaID]
        if (channelId === materia.canalTextoID) {
            return { materiaID, materiaData: materia }
        }
    }
    return null
}

async function getMateriaFromUser(member: GuildMember, channel: TextBasedChannels) {
    let materiaID: string = null
    let selectCourseMessage: Message = await sendCoursesSelect(member, channel)

    // console.debug(selectCourseMessage)

    if (!selectCourseMessage) return null

    const filter = i => {
        // i.deferUpdate();
        return i.user.id === member.id;
    };

    let selectCourseInteraction: SelectMenuInteraction = null

    /// try to send select message for user to choose
    try {
        selectCourseInteraction = await selectCourseMessage.awaitMessageComponent({ filter, componentType: 'SELECT_MENU', time: Configs["ButtonDefaultTimeout"] * 1000 })
        selectCourseInteraction.deferUpdate()

        materiaID = selectCourseInteraction.values[0]
    } catch (error) {
        console.error(error)

        /// user waited too much to interact
        let messageContent = { content: `**😢 Você me deixou no vácuo! 😢**`, components: [] }
        selectCourseMessage.edit(messageContent)

        selectCourseInteraction = null
    }

    return { materiaID, materiaData: Materias[materiaID] }
}

export async function sendCoursesSelect(member: GuildMember, channel: TextBasedChannels) {
    let messageToSend: any = {}

    /// get option of the current year
    let options = await getMemberCoursesRoles(member as GuildMember)

    /// if there are options to choose
    if (options.length > 0) {
        let optionsChunks = options.reduce((all, one, i) => {
            const ch = Math.floor(i / 25);
            all[ch] = [].concat((all[ch] || []), one);
            return all
        }, [])

        // console.debug(optionsChunks)

        let selectRows: MessageActionRow[] = []
        optionsChunks.forEach((chunk, index) => {

            let placeHolderAuxStr = (index) ? "Continuação da " : ""
            /// create row element to show
            let row = new MessageActionRow().addComponents(
                new MessageSelectMenu()
                    .setCustomId(`selectCourseSelect|${index}`)
                    .setPlaceholder(`${placeHolderAuxStr}Lista de Matérias`)
                    .addOptions(chunk),
            )

            selectRows.push(row)
        });

        /// createView
        messageToSend = {
            content: `**Selecione uma matéria para mostrar as informações:**`,
            components: selectRows,
            fetchReply: true
        }
    } else {
        messageToSend = { content: '**Você não está escrito em nenhuma matéria**', fetchReply: true }
        return null
    }

    /// send to member
    return await channel.send(messageToSend) as Message
}

async function getMemberCoursesRoles(member: GuildMember) {
    let selectOptions = []

    member.roles.cache.forEach(role => {
        if (role.id in Materias) {
            let materia: MateriaData = Materias[role.id]
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

async function sendMateriaInfoMessage(materia: Materia, member: GuildMember, channel: TextBasedChannels) {
    /// create description string
    let materiaProfessoresStr: string = `**Professor:** \`${materia.materiaData.professores[0].nome}\``;

    /// if there's more than 1 professor, apply a reduce
    if ((materia.materiaData.professores.length > 1))
        materiaProfessoresStr = `**Professores:** \`${materia.materiaData.professores.map(prof => {return prof.nome}).reduce((prev: string, curr: string) => { return `${prev}, ${curr}` })}\``;

    let materiaDesc = `**Matéria de** \`${materia.materiaData.nomeMateria}\`\n\
        **Código:** \`${materia.materiaData.codMateria}\`\n\
        \`${materia.materiaData.cargaHorariaEmHoras}\` **hrs aula**\n\
        **Série:** \`${materia.materiaData.serie}\`\n\
        ${materiaProfessoresStr}\n\
    `

    let materiaEmbed = new MessageEmbed()
        .setColor('#4f258a')
        .setTitle(materia.materiaData.nomeMateria)
        .setDescription(materiaDesc)
        .setTimestamp()
        .setFooter((member as GuildMember).displayName, (member as GuildMember).displayAvatarURL());

    /// send to member
    return await channel.send({ content: `**Informações da matéria:**`, embeds: [materiaEmbed]}) as Message
}