import { Command, ControlRoles } from '../../Interfaces'
import Logger from '../../Logger'
import Configs from '../../config.json'
import { isAllowed } from '../../Utils'
const log = Logger(Configs.CommandsLogLevel, 'eval.ts')

export const command: Command = {
    name: 'eval',
    aliases: [],
    description: 'Nem pense nisso',
    allowedRoles: (<any>Object).values(ControlRoles),
    run: async (client, message, args) => {
        try {
            let res = "RESULT: " + await eval(args.join(""))
            message.reply(res)
        } catch (error) {
            message.reply("ERROR: " + error)
        }
    }
}
/**

l.eval
message.channel.messages.fetch().then(messages => {
    message.channel.bulkDelete(messages);
})

*/

