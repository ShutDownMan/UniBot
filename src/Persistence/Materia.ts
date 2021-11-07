import { Horario } from "./Horario"
import { Professor } from "./Professor";

export interface MateriaData {
    canalTextoID: string
    nomeMateria: string
    codMateria: string
    cargaHorariaEmHoras: Number,
    serie: string
    horarios: Horario[]
    professores: Professor[]
}

export interface Materia {
    materiaID: string
    materiaData: MateriaData
}