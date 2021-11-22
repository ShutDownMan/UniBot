import { ButtonInteraction, GuildMember, Interaction, MessageActionRow, MessageSelectMenu } from "discord.js"
import { getMemberCoursesRoles } from "../../Utils"

export async function createRemoveCoursesSelect(client, interaction: Interaction) {
    let messageToSend: any = {}

    /// get option of the current year
    let options = await getMemberCoursesRoles(interaction.member as GuildMember)

    /// if there are options to choose
    if (options.length > 0) {
        let defaultOption = {
            label: "Todas as Matérias",
            description: "Remova todas as matérias atuais",
            value: "removeAll"
        }
        options = [defaultOption].concat(options)

        let optionsChunks = options.reduce((all, one, i) => {
            const ch = Math.floor(i / 25);
            all[ch] = [].concat((all[ch] || []), one);
            return all
        }, [])

        let selectRows: MessageActionRow[] = []
        optionsChunks.forEach((chunk, index) => {

            let placeHolderAuxStr = (index) ? "Continuação da " : ""
            /// create row element to show
            let row = new MessageActionRow().addComponents(
                new MessageSelectMenu()
                    .setCustomId(`removeCoursesSelect|${index}`)
                    .setPlaceholder(`${placeHolderAuxStr}Lista de Matérias`)
                    .setMaxValues(chunk.length)
                    .addOptions(chunk),
            )

            selectRows.push(row)
        });

        /// createView
        messageToSend = {
            content: `**Selecione as matérias para remover**`,
            components: selectRows,
            ephemeral: true
        }
    } else {
        messageToSend = { content: '**Você não está escrito em nenhuma matéria**', ephemeral: true }
    }

    /// send to member
    await (interaction as ButtonInteraction).reply(messageToSend)
}