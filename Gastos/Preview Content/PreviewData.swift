//
//  PreviewData.swift
//  Gastos
//
//  Created by Pedro Muñoz on 19/09/22.
//

import Foundation
import SwiftUI

let uuidg1 = UUID()
let uuidg2 = UUID()

var gruposPreviewData = [
	Grupo(id: uuidg1, nombre: "Viaje", descripcion: nil),
	Grupo(id: uuidg2, nombre: "Viaje2", descripcion: nil)
]

var gastoPreviewData = Gasto(
	id: UUID(),
	idGrupo: uuidg1,
	concepto: "Videojuego",
	cantidad: 11.49,
	fecha: Date(),
	idCategoria: 801,
	detalles: "para la compu"
)

var gastosListPreviewData = [Gasto](repeating: gastoPreviewData, count: 10)

var gastosPreviewData = [
	Gasto(
		id: UUID(),
		idGrupo: uuidg1,
		concepto: "Comida",
		cantidad: 120,
		fecha: Date(),
		idCategoria: 502,
		detalles: "Boneless"
	),
	Gasto(
		id: UUID(),
		idGrupo: uuidg1,
		concepto: "Uber",
		cantidad: 60.0,
		fecha: Date(),
		idCategoria: 102,
		detalles: nil
	),
	Gasto(
		id: UUID(),
		idGrupo: uuidg2,
		concepto: "Camion",
		cantidad: 9.0,
		fecha: Date(),
		idCategoria: 101,
		detalles: nil
	),
	Gasto(
		id: UUID(),
		idGrupo: uuidg2,
		concepto: "Dulces",
		cantidad: 10,
		fecha: Date(),
		idCategoria: 0,
		detalles: nil
	)
]
