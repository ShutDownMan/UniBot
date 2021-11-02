import { Event } from '../Interfaces'
import { ButtonInteraction, GuildMember, Interaction, MessageActionRow, MessageSelectMenu, SelectMenuInteraction } from 'discord.js'
import Materias from '../../data/materias.json'
import Logger from '../Logger'
import Configs from '../config.json'
import { sendToTextChannel } from '../Utils'
const log = Logger(Configs.EventsLogLevel, 'interactionCreate.ts')

export const event: Event = {
    name: 'interactionCreate',
    run: async (client, interaction: Interaction) => {

        // eval(interaction)
        if (interaction.isSelectMenu()) {
            let selectInteraction = interaction as SelectMenuInteraction

            // log.debug(selectInteraction.values)

            await selectInteraction.deferUpdate();

            runSelectInteraction(client, interaction)
        }

        if (interaction.isButton()) {
            let buttonInteraction = interaction as ButtonInteraction

            await buttonInteraction.deferUpdate();

            runButtonInteraction(client, buttonInteraction)

        }

    }
}

async function runSelectInteraction(client, interaction: SelectMenuInteraction) {
    switch (interaction.customId) {
        case "bulkEnrollCoursesSelect":
            await addCoursesFromPeriod(interaction.member as GuildMember, interaction.values[0])
            await interaction.user.send("🤖 **Matérias adicionadas** 🤖")
            break;
        case "FirstYearEnrollCoursesSelect":
        case "SecondYearEnrollCoursesSelect":
        case "ThirdYearEnrollCoursesSelect":
        case "FourthYearEnrollCoursesSelect":
            await addBulkRoles(interaction.member as GuildMember, interaction.values)
            await interaction.user.send("🤖 **Matérias adicionadas** 🤖")
            break;
        case "removeCoursesSelect":
            await removeBulkRoles(interaction.member as GuildMember, interaction.values)
            await interaction.user.send("🤖 **Matérias removidas** 🤖")
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
    rolesID.forEach(roleID => {
        addRole(member, roleID);
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
    rolesID.forEach(roleID => {
        removeRole(member, roleID);
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

        messageToSend = { content: '**Escolha os cursos para remover**', components: [row] }
    } else {
        messageToSend = { content: '**Você não está escrito em nenhuma matéria**' }
    }

    /// send to member dms
    await interaction.user.send(messageToSend)
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