import { Event } from '../Interfaces'
import { ButtonInteraction, GuildMember, Interaction, Message, MessageActionRow, MessageSelectMenu, SelectMenuInteraction } from 'discord.js'
import Materias from '../../data/materias.json'
import Logger from '../Logger'
import Configs from '../config.json'
import { deleteAfter, sendToTextChannel } from '../Utils'
import ExtendedClient from '../Client'
const log = Logger(Configs.EventsLogLevel, 'interactionCreate.ts')

export const event: Event = {
    name: 'interactionCreate',
    run: async (client, interaction: Interaction) => {

        // eval(interaction)
        if (interaction.isSelectMenu()) {
            let selectInteraction = interaction as SelectMenuInteraction

            // log.debug(selectInteraction.values)

            // await selectInteraction.deferUpdate();

            await runSelectInteraction(client, selectInteraction)
        }

        if (interaction.isButton()) {
            let buttonInteraction = interaction as ButtonInteraction

            // await buttonInteraction.deferUpdate();

            runButtonInteraction(client, buttonInteraction)

        }

    }
}

async function runSelectInteraction(client: ExtendedClient, interaction: SelectMenuInteraction) {
    let splittedInteractionCustomID = interaction.customId.split("|")
    let interactionName = splittedInteractionCustomID[0]
    let args = splittedInteractionCustomID.splice(1, splittedInteractionCustomID.length)

    let reply: Message = undefined;
    switch (interactionName) {
        case "bulkEnrollCoursesSelect":
            await interaction.reply({content: "🤖 **Adicionando matérias** 🤖", ephemeral: true})

            await addCoursesFromPeriod(interaction.member as GuildMember, interaction.values[0])
            reply = await interaction.editReply("🤖 **Matérias adicionadas** 🤖") as Message

            await (interaction.message as Message).edit((interaction.message as Message).content)

            deleteAfter(reply, 15)
            break;
        case "PrimeiroYearEnrollCoursesSelect":
        case "SegundoYearEnrollCoursesSelect":
        case "TerceiroYearEnrollCoursesSelect":
        case "QuartoYearEnrollCoursesSelect":
            await interaction.reply({content: "🤖 **Adicionando matérias** 🤖", ephemeral: true})

            await addBulkRoles(interaction.member as GuildMember, interaction.values)
            reply = await interaction.editReply("🤖 **Matérias adicionadas** 🤖") as Message

            await (interaction.message as Message).edit((interaction.message as Message).content)

            deleteAfter(reply, 15)
            break;
        case "removeCoursesSelect":
            await interaction.reply({content: "🤖 **Removendo matérias** 🤖", ephemeral: true})

            await removeBulkRoles(interaction.member as GuildMember, interaction.values)
            reply = await interaction.editReply("🤖 **Matérias removidas** 🤖") as Message

            // await interaction.deleteReply()
            // await (interaction.message as Message).delete()
            break;
    }
}

async function addCoursesFromPeriod(member: GuildMember, period: string) {
    /// fetch by period from materias
    let materiasFromPeriods = Object.keys(Materias).filter((key: string) => { return period === Materias[key].serie })

    // log.debug(materiasFromPeriods)

    materiasFromPeriods.forEach(materiaID => {
        addRole(member, materiaID)
    })

}

async function addBulkRoles(member: GuildMember, rolesID: string[]) {
    rolesID.forEach(async roleID => {
        await addRole(member, roleID);
    })
}

async function addRole(member: GuildMember, roleID: string) {
    try {
        member.guild.roles.fetch(roleID).then(role => {
            member.roles.add(role)
        })
    } catch (error) {
        log.error(error)
    }
}

async function removeBulkRoles(member: GuildMember, rolesID: string[]) {
    rolesID.forEach(async roleID => {
        await removeRole(member, roleID);
    })
}

async function removeRole(member: GuildMember, roleID: string) {
    try {
        member.guild.roles.fetch(roleID).then(role => {
            member.roles.remove(role)
        })
    } catch (error) {
        log.error(error)
    }
}

async function runButtonInteraction(client, interaction: ButtonInteraction) {
    switch (interaction.customId) {
        case "removeCoursesRoles":
            createRemoveCoursesSelect(client, interaction)
            break;
        default:
            await interaction.reply({ content: 'Interaction not Implemented', ephemeral: true });
            break;
    }
}

async function createRemoveCoursesSelect(client, interaction: Interaction) {
    let messageToSend: any = {}

    /// get option of the current year
    let options = await getMemberCoursesRoles(interaction.member as GuildMember)

    /// if there are options to choose
    if (options.length > 0) {
        /// create row element to show
        let row = new MessageActionRow().addComponents(
            new MessageSelectMenu()
                .setCustomId(`removeCoursesSelect`)
                .setPlaceholder(`Lista de Matérias`)
                .setMaxValues(options.length)
                .addOptions(options),
        )

        /// createView
        let currentYearEnrollView = {
            content: `**Selecione as matérias para remover**`,
            components: [row]
        }

        messageToSend = { content: '**Escolha os cursos para remover**', ephemeral: true, components: [row] }
    } else {
        messageToSend = { content: '**Você não está escrito em nenhuma matéria**', ephemeral: true }
    }

    /// send to member dms
    await (interaction as ButtonInteraction).reply(messageToSend)
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