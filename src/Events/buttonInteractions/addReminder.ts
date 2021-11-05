import { ButtonInteraction, GuildMember, Interaction, Message, MessageActionRow, MessageSelectMenu, SelectMenuInteraction, TextChannel } from "discord.js"
import Materias from '../../../data/materias.json'
import Logger from '../../Logger'
import Configs from '../../config.json'
import ExtendedClient from "../../Client"
import { Materia } from "../../Persistence/Materia"
const log = Logger(Configs.EventsLogLevel, 'addReminder.ts')

export async function addReminder(client: ExtendedClient, interaction: ButtonInteraction) {
    let materia: Materia = getCourseTextChannel(interaction.channelId)

    /// get from which materia user wants to add reminder to
    let materiaID: string = interaction.channelId
    if (!materia) {
        materiaID = await getMateriaFromUser(interaction)
        materia = Materias[materiaID]

        if (!materiaID) return;
    }
}

function getCourseTextChannel(channelId: string) {
    for (let materiaID of Object.keys(Materias)) {
        let materia: Materia = Materias[materiaID]
        if (channelId === materia.canalTextoID) {
            return materia
        }
    }
    return null
}

async function getMateriaFromUser(interaction: ButtonInteraction) {
    let materiaID: string = null
    let selectCourseMessage: Message = await sendCoursesSelect(interaction)

    const filter = i => {
        i.deferUpdate();
        return i.user.id === interaction.user.id;
    };

    try {
        let selectCourseInteraction: SelectMenuInteraction = await selectCourseMessage.awaitMessageComponent({ filter, componentType: 'SELECT_MENU', time: 60000 })

        // await selectCourseInteraction.editReply(`You selected ${}!`)
        materiaID = selectCourseInteraction.values[0]

    } catch (error) {
        console.error(error)
    }

    return materiaID
}


export async function sendCoursesSelect(interaction: ButtonInteraction) {
    let messageToSend: any = {}

    /// get option of the current year
    let options = await getMemberCoursesRoles(interaction.member as GuildMember)

    /// if there are options to choose
    if (options.length > 0) {
        let defaultOption = {
            label: "Todas as Matérias",
            description: "Remova todas as matérias atuais",
            value: "removeAll"
        }
        options = [defaultOption].concat(options)

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
            content: `**Selecione uma matéria para adicionar o lembrete:**`,
            components: selectRows,
            ephemeral: true
        }
    } else {
        messageToSend = { content: '**Você não está escrito em nenhuma matéria**', ephemeral: true }
    }

    /// send to member
    return await interaction.reply(messageToSend) as Message
}

async function getMemberCoursesRoles(member: GuildMember) {
    let selectOptions = []

    member.roles.cache.forEach(role => {
        if (role.id in Materias) {
            let materia = Materias[role.id]
            /// create description string
            let materiaProfessoresStr = materia.professores[0].nome

            /// if there's more than 1 professor, apply a reduce
            if ((materia.professores.length > 1))
                materiaProfessoresStr = materia.professores.reduce((prev: { nome: string }, curr: { nome: string }) => { return `${prev.nome}, ${curr.nome}` })

            selectOptions.push({
                label: materia.nomeMateria,
                description: `${materiaProfessoresStr}`,
                value: `${role.id}`,
            })
        }
    })

    return selectOptions
}