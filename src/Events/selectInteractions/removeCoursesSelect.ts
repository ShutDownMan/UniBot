import { GuildMember } from "discord.js"
import Materias from '../../../data/materias.json'
import Logger from '../../Logger'
import Configs from '../../config.json'
const log = Logger(Configs.EventsLogLevel, 'removeCoursesSelect.ts')


export async function removeBulkCourses(member: GuildMember, rolesID: string[]) {
    await Promise.all(rolesID.map(async roleID => {
        if (roleID === "removeAll") {
            await removeAllCourses(member)
            return
        }
        await removeRole(member, roleID);
    }))
}

async function removeAllCourses(member: GuildMember) {
    await Promise.all(member.roles.cache.map(async role => {
        if (role.id in Materias) {
            await removeRole(member, role.id)
        }
    }))
}

async function removeRole(member: GuildMember, roleID: string) {
    try {
        let role = await member.guild.roles.fetch(roleID)
        await member.roles.remove(role)
    } catch (error) {
        console.error(error)
    }
}
