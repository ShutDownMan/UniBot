import { Command, ControlRoles } from '../../Interfaces'
import Logger from '../../Logger'
import Configs from '../../config.json'
import { getMemberCoursesRoles, isAllowed } from '../../Utils'
const log = Logger(Configs.CommandsLogLevel, 'eval.ts')

export const command: Command = {
    name: 'eval',
    aliases: [],
    description: 'Nem pense nisso',
    allowedRoles: (<any>Object).values(ControlRoles),
    run: async (client, message, args) => {
        try {
            let res = "RESULT: " + await eval("(async () => {" + args.join("") + "})()")
            if (res) message.reply(res.toString())
        } catch (error) {
            message.reply("ERROR: " + error.toString())
        }
    }
}

/**

/// PURGE
l.eval
message.channel.messages.fetch().then(messages => {
    message.channel.bulkDelete(messages);
})

/// ALERT NO MATERIA USERS
l.eval
const Materias = require('../../../data/materias.json')
async function getMemberCoursesRoles(member) {
    let selectOptions = []

    member.roles.cache.forEach(role => {
        if (role.id in Materias) {
            let materia = Materias[role.id]
            selectOptions.push(materia)
        }
    })

    return selectOptions
}

let guild = await message.guild.fetch()
let members = await guild.members.fetch()
for(let member of members.values()) {
    if(!member.user.bot) {
        let materiasFromUser = await getMemberCoursesRoles(member)

        if(materiasFromUser.length === 0) {
            console.debug("sending to " + member)
            await member.send("**🤖 Olá, tudo bem? 🤖\nPercebi que ainda não colocou nenhuma matéria no servidor, e sem os cargos não vai receber as notificações das aulas...\n\nDeixa-me te ajudar: Vá até o canal de texto <#904119001024716860> e selecione as matérias que está cursando.**")
        }
    }
}

*/

