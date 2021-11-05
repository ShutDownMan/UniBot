import { GuildMember } from "discord.js"
import Materias from '../../../data/materias.json'
import Logger from '../../Logger'
import Configs from '../../config.json'
const log = Logger(Configs.EventsLogLevel, 'bulkEnrollCoursesSelect.ts')

export async function addCoursesFromPeriod(member: GuildMember, period: string) {
    /// fetch by period from materias
    let materiasFromPeriods = Object.keys(Materias).filter((key: string) => { return period === Materias[key].serie })

    await Promise.all(materiasFromPeriods.map(async materiaID => {
        await addRole(member, materiaID)
    }))
}

async function addRole(member: GuildMember, roleID: string) {
    try {
        let role = await member.guild.roles.fetch(roleID)
        await member.roles.add(role)
    } catch (error) {
        console.error(error)
    }
}