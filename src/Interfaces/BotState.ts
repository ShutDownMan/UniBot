/**
 * Control roles are the ones allowed to make changes to bot behaviour at runtime
 */
export enum ControlRoles {
    Admin = '880441633366224916',
    Moderator = '880441901684244500',
    Dev = '876107010419073054',
}

/**
 * Course enrolling messages from the #matérias text channel
 */
export enum EnrollMessages {
    PerYearEnrollMessageID = '904131873029099580',
    FirstYearEnrollMessageID = '904131960748802089',
    SecondYearEnrollMessageID = '904131992046669834',
    ThirdYearEnrollMessageID = '904132047642189834',
    FourthYearEnrollMessageID = '904132092982616154',
    ManageEnrollsMessageID = '904132173513261086',
}

/**
 * @clear clears the state
 */
export interface BotState {
    prefix: string
    controlRoles: ControlRoles[]
    enrollMessages: EnrollMessages[]
    clear()
}