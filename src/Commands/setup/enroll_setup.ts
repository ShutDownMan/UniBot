import { Command, ControlRoles, EnrollMessages } from '../../Interfaces'
import Logger from '../../Logger'
import Configs from '../../config.json'
import { Client, Emoji, Message, MessageActionRow, MessageButton, MessageSelectMenu, TextChannel } from 'discord.js'
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

        /// create enroll management message
        await createManagementMenu(client)

        /// delete sent command
        await tryAndDelete(message)
    }
}

async function clearChannelMessages(client) {
    await client.channels.fetch(process.env.ENROLLMENT_CHANNEL).then(async channel => {
        await (channel as TextChannel).messages.fetch().then(async messages => {
            await (channel as TextChannel).bulkDelete(messages);
        })
    }).catch(error => {
        console.error(error)
    })

}

async function createBulkCoursesSelect(client: ExtendedClient) {
    let options = getAllYearsAsOptions()
    /// create select with each year
    let row = new MessageActionRow().addComponents(
        new MessageSelectMenu()
            .setCustomId('bulkEnrollCoursesSelect')
            .setPlaceholder('Adicionar Matérias Por Ano')
            .addOptions(options),
    )
    /// create view
    let bulkYearsEnrollView = {
        content: "**Adicionar TODAS as Matérias por Ano**",
        components: [row]
    }

    /// send view to channel
    await sendToTextChannel(client, process.env.ENROLLMENT_CHANNEL, bulkYearsEnrollView)
}

function getAllYearsAsOptions() {
    let cardinals = ["Primeiro", "Segundo", "Terceiro", "Quarto"]
    let yearOptions = []

    /// for each year
    for (let index = 0; index < cardinals.length; index++) {

        /// create option
        let yearOption = {
            label: `${cardinals[index]} Ano`,
            description: `Adicione todas matérias do ${cardinals[index]} ano`,
            value: `${index + 1}`,
        }

        /// add to array
        yearOptions.push(yearOption)
    }

    return yearOptions
}

async function createByYearSelects(client: ExtendedClient) {
    let cardinals = ["Primeiro", "Segundo", "Terceiro", "Quarto"]

    /// for each year
    for (let index = 0; index < cardinals.length; index++) {

        /// get option of the current year
        let yearStrs = [`${index+1}`, `${index+1}D`]
        let options = getOptionsByYears(yearStrs)
        /// if there are options to choose
        if(options.length > 0) {
            /// create row element to show
            let row = new MessageActionRow().addComponents(
                new MessageSelectMenu()
                    .setCustomId(cardinals[index] + 'YearEnrollCoursesSelect')
                    .setPlaceholder(`Matérias do ${cardinals[index]} Ano`)
                    .setMaxValues(options.length)        
                    .addOptions(options),
            )

            /// createView
            let currentYearEnrollView = {
                content: `**${cardinals[index]} Ano**`,
                components: [row]
            }
    
            /// send view to channel
            await sendToTextChannel(client, process.env.ENROLLMENT_CHANNEL, currentYearEnrollView)    
        }
    }

}

function getOptionsByYears(periods: string[]) {
    /// fetch by period from materias
    let materiasFromPeriods = Object.keys(Materias).filter(k => { return isFromGivenPeriod(periods, k) })

    // console.debug(materiasFromPeriods)

    let selectOptions = []

    materiasFromPeriods.forEach(materiaID => {
        let materia = Materias[materiaID]

        /// create description string
        let materiaProfessoresStr = materia.professores[0].nome
        /// if there's more than 1 professor, apply a reduce
        if ((materia.professores.length > 1))
            materiaProfessoresStr = materia.professores.reduce((prev: { nome: string }, curr: { nome: string }) => { return `${prev.nome}, ${curr.nome}` })

        // console.debug(materiaProfessoresStr)

        let materiaOption = {
            label: materia.nomeMateria,
            description: `${materiaProfessoresStr}`,
            value: `${materiaID}`,
        }
        selectOptions.push(materiaOption)

    })

    return selectOptions
}

function isFromGivenPeriod(array: string[], key: string) {
    return array.some((p: string) => { return p === Materias[key].serie })
}

async function createManagementMenu(client: Client) {
    /// create select with each year
    let firstRow = new MessageActionRow().addComponents(
        new MessageButton()
            .setCustomId('removeCoursesRoles')
            .setEmoji("❌")
            .setLabel("Remover Matérias")
            .setStyle("DANGER"),
    )
    /// create view
    let managementView = {
        content: "**Gerenciar Matérias**",
        components: [firstRow]
    }

    /// send view to channel
    await sendToTextChannel(client, process.env.ENROLLMENT_CHANNEL, managementView)
}

async function tryAndDelete(item: Message) {
    try {
        await item.delete()
    } catch (error) {
        console.error(error)            
    }
}

/*
*/