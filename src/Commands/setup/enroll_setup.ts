import { Command, ControlRoles, EnrollMessages } from '../../Interfaces'
import Logger from '../../Logger'
import Configs from '../../config.json'
import { MessageActionRow, MessageSelectMenu, TextChannel } from 'discord.js'
import Materias from '../../../data/materias.json'
import ExtendedClient from '../../Client'
import { sendToTextChannel } from '../../Utils'
const log = Logger(Configs.CommandsLogLevel, 'enroll_setup.ts')

export const command: Command = {
    name: 'enroll_setup',
    aliases: [],
    description: 'Nem pense nisso',
    allowedRoles: (<any>Object).values(ControlRoles),
    run: async (client, message, args) => {

        /// clear all messages from channel
        await clearChannelMessages(client)

        /// create bulk courses select
        await createBulkCoursesSelect(client)

        /// create a select for each period
        await createByYearSelects(client)

        try {
            await message.delete()
        } catch (error) {
            log.error(error)            
        }
    }
}

async function clearChannelMessages(client) {
    await client.channels.fetch(process.env.ENROLLMENT_CHANNEL).then(async channel => {
        await (channel as TextChannel).messages.fetch().then(async messages => {
            await (channel as TextChannel).bulkDelete(messages);
        })
    }).catch(error => {
        log.error(error)
    })

}

async function createBulkCoursesSelect(client: ExtendedClient) {
    let row = new MessageActionRow().addComponents(
        new MessageSelectMenu()
            .setCustomId('bulkEnrollCoursesSelect')
            .setPlaceholder('Adicionar Matérias Por Ano')
            .addOptions(getAllYearsAsOptions()),
    )
    let bulkYearsEnrollView = {
        content: "**Adicionar Matérias Por Ano**",
        components: [row]
    }

    await sendToTextChannel(client, process.env.ENROLLMENT_CHANNEL, bulkYearsEnrollView)
}

function getAllYearsAsOptions() {
    let cardinals = ["Primeiro", "Segundo", "Terceiro", "Quarto"]
    let yearOptions = []

    for (let index = 0; index < cardinals.length; index++) {

        let yearOption = {
            label: `${cardinals[index]} Ano`,
            description: `Adicione todas matérias do ${cardinals[index]} ano.`,
            value: (index + 1).toString(),
        }

        yearOptions.push(yearOption)
    }

    return yearOptions
}

async function createByYearSelects(client: ExtendedClient) {
    let cardinals = ["Primeiro", "Segundo", "Terceiro", "Quarto"]

    for (let index = 0; index < cardinals.length; index++) {

        let yearStrs = [`${index+1}`]
        let options = getOptionsByYears(yearStrs)
        if(options.length > 0) {
            let row = new MessageActionRow().addComponents(
                new MessageSelectMenu()
                    .setCustomId(cardinals[index] + 'YearEnrollCoursesSelect')
                    .setPlaceholder(`Matérias do ${cardinals[index]} Ano`)
                    .addOptions(options),
            )
            let currentYearEnrollView = {
                content: `**${cardinals[index]} Ano**`,
                components: [row]
            }
    
            await sendToTextChannel(client, process.env.ENROLLMENT_CHANNEL, currentYearEnrollView)    
        }
    }

}

function getOptionsByYears(periods: string[]) {
    /// fetch by period from materias
    let materiasFromPeriods = Object.keys(Materias).filter(k => { return isFromGivenPeriod(periods, k) })

    // log.debug(materiasFromPeriods)

    let selectOptions = []

    materiasFromPeriods.forEach(materiaID => {
        let materia = Materias[materiaID]

        /// create description string
        let materiaProfessoresStr = "Professor: " + materia.professores[0].nome
        /// if there's more than 1 professor, apply a reduce
        if ((materia.professores.length > 1))
            materiaProfessoresStr = "Professores: " + materia.professores.reduce((prev: { nome: string }, curr: { nome: string }) => { return `${prev.nome}, ${curr.nome}` })

        // log.debug(materiaProfessoresStr)

        let materiaOption = {
            label: materia.nomeMateria,
            description: `${materiaProfessoresStr}`,
            value: materiaID,
        }
        selectOptions.push(materiaOption)

    })

    return selectOptions
}

function isFromGivenPeriod(array: string[], key: string) {
    return array.some((p: string) => { return p === Materias[key].serie })
}

/*
*/