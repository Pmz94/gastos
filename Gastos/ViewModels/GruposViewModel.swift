//
//  GruposViewModel.swift
//  Gastos
//
//  Created by Pedro Muñoz on 22/09/22.
//

import Foundation

final class GruposViewModel: ObservableObject {
	@Published var grupos: [Grupo] = []
	private var dataManager: DataManager

	init() {
		dataManager = DataManager()
		grupos = dataManager.getGrupos()
	}

	func addGrupo(nombre: String, descripcion: String = "") {
		let grupo = Grupo(
			id: UUID(),
			nombre: nombre.trim(),
			descripcion: descripcion != "" ? descripcion.trim() : nil
		)
		dataManager.addGrupo(grupo: grupo)
		grupos = dataManager.getGrupos()
	}

	func borrarGrupo(id: UUID) {
		dataManager.borrarGrupo(id: id)
		grupos = dataManager.getGrupos()
	}
}
