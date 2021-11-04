import { Event } from '../Interfaces'
import { ButtonInteraction, GuildMember, Interaction, Message, MessageActionRow, MessageSelectMenu, SelectMenuInteraction } from 'discord.js'
import Logger from '../Logger'
import Configs from '../config.json'
import { deleteAfter, sendToTextChannel } from '../Utils'
import ExtendedClient from '../Client'
import { createRemoveCoursesSelect } from './buttonInteractions/removeCoursesRoles'
import { addCoursesFromPeriod } from './selectInteractions/bulkEnrollCoursesSelect'
import { addBulkRoles } from './selectInteractions/yearEnrollCoursesSelect'
import { removeBulkCourses } from './selectInteractions/removeCoursesSelect'
const log = Logger(Configs.EventsLogLevel, 'interactionCreate.ts')

export const event: Event = {
    name: 'interactionCreate',
    run: async (client, interaction: Interaction) => {

        // eval(interaction)
        if (interaction.isSelectMenu()) {
            let selectInteraction = interaction as SelectMenuInteraction

            // log.debug(selectInteraction.values)

            // await selectInteraction.deferUpdate();

            try {
                await runSelectInteraction(client, selectInteraction)

            } catch (error) {
                log.error(error)
            }
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
            await interaction.reply({ content: "🤖 **Adicionando Matérias...** 🤖", ephemeral: true })

            await addCoursesFromPeriod(interaction.member as GuildMember, interaction.values[0])
            reply = await interaction.editReply("🤖 **Matérias Adicionadas** 🤖") as Message

            await (interaction.message as Message).edit((interaction.message as Message).content)
            break;
        case "PrimeiroYearEnrollCoursesSelect":
        case "SegundoYearEnrollCoursesSelect":
        case "TerceiroYearEnrollCoursesSelect":
        case "QuartoYearEnrollCoursesSelect":
            await interaction.reply({ content: "🤖 **Adicionando Matérias...** 🤖", ephemeral: true })

            await addBulkRoles(interaction.member as GuildMember, interaction.values)
            reply = await interaction.editReply("🤖 **Matérias Adicionadas** 🤖") as Message

            await (interaction.message as Message).edit((interaction.message as Message).content)
            break;
        case "removeCoursesSelect":
            await interaction.reply({ content: "🤖 **Removendo Matérias...** 🤖", ephemeral: true })

            await removeBulkCourses(interaction.member as GuildMember, interaction.values)
            reply = await interaction.editReply("🤖 **Matérias Removidas** 🤖") as Message
            break;
        case "addTextReminder":
            break;
        case "addAssignmentReminder":
            break;
        case "addExamReminder":
            break;
        case "addProjectReminder":
            break;
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
