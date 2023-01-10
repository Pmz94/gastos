//
//  Gasto.swift
//  Gastos
//
//  Created by Pedro Muñoz on 19/09/22.
//

import Foundation
import SwiftUIFontIcon

struct Gasto: Identifiable, Decodable, Hashable {
	let id: UUID
	let idGrupo: UUID
	var concepto: String
	let cantidad: Double
	let fecha: Date
	var idCategoria: Int
	let detalles: String?

	var icono: FontAwesomeCode {
		if let category = Category.all.first(where: { $0.id == idCategoria }) {
			return category.icon
		} else {
			return .dollar_sign
		}
	}

	var categoria: String {
		if let category = Category.all.first(where: { $0.id == idCategoria }) {
			return category.name
		} else {
			return "Otro"
		}
	}

	var mes: String {
		fecha.formatted(.dateTime.year().month(.wide))
	}
}
