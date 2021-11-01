import { Event } from '../Interfaces'
import { GuildMember, Interaction, SelectMenuInteraction } from 'discord.js'
import Materias from '../../data/materias.json'
import Logger from '../Logger'
import Configs from '../config.json'
const log = Logger(Configs.EventsLogLevel, 'interactionCreate.ts')

export const event: Event = {
    name: 'interactionCreate',
    run: async (client, interaction: Interaction) => {

        // eval(interaction)
        if (interaction.isSelectMenu()) {
            let selectInteraction = interaction as SelectMenuInteraction

            log.debug(selectInteraction.values)

            await selectInteraction.deferUpdate();

            selectInteraction.values.forEach(value => {
                let splitedValue = value.split(" ")

                runInteraction(client, interaction, splitedValue[0], splitedValue.splice(1, splitedValue.length - 1))

            });


        }

    }
}

async function runInteraction(client, interaction: Interaction, interactionName: string, args?: string[]) {
    switch (interactionName) {
        case "addCoursesFromPeriod":
            let period = args[0]
            await addCoursesFromPeriod(interaction.member as GuildMember, period)
            break;
        case "addRole":
            let roleID = args[0]
            await addRole(interaction.member as GuildMember, roleID)
            break;
    }
}

async function addCoursesFromPeriod(member: GuildMember, period: string) {
    /// fetch by period from materias
    let materiasFromPeriods = Object.keys(Materias).filter((key: string) => { return period === Materias[key].serie })

    log.debug(materiasFromPeriods)

    materiasFromPeriods.forEach(materiaID => {
        addRole(member, materiaID)
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