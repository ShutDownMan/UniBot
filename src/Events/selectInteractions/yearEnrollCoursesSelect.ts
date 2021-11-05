import { GuildMember } from "discord.js"
import Materias from '../../../data/materias.json'
import Logger from '../../Logger'
import Configs from '../../config.json'
const log = Logger(Configs.EventsLogLevel, 'yearEnrollCoursesSelect.ts')

export async function addBulkRoles(member: GuildMember, rolesID: string[]) {
    await Promise.all(rolesID.map(async roleID => {
        await addRole(member, roleID);
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