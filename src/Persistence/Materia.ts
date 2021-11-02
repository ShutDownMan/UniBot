import { Horario } from "./Horario"
import { Professor } from "./Professor";

export interface Materia {
    canalTextoID: string
    nomeMateria: string
    codMateria: string
    cargaHorariaEmHoras: Number,
    serie: string
    horarios: Horario[]
    professores: Professor[]
}