//
//  GastosViewModel.swift
//  Gastos
//
//  Created by Pedro Muñoz on 19/09/22.
//

import Foundation
import Collections

typealias GastosAgrupados = OrderedDictionary<String, [Gasto]>
typealias GastosPrefixSum = [(String, Double)]

final class GastosViewModel: ObservableObject {
	@Published var gastos: [Gasto] = []
	private var idGrupo: UUID = UUID()
	private var dataManager: DataManager

	init(idGrupo: UUID) {
		self.idGrupo = idGrupo
		dataManager = DataManager()
		gastos = dataManager.getGastos(idGrupo: self.idGrupo)
	}

	func agruparGastosPorMes() -> GastosAgrupados {
		guard !gastos.isEmpty else { return [:] }
		let gastosAgrupados = GastosAgrupados(grouping: gastos) { $0.mes }
		return gastosAgrupados
	}

	func totalGastos() -> [Double] {
		return gastos.map { $0.cantidad }.reversed()
	}

	func addGasto(idGrupo: UUID, concepto: String, cantidad: String, fecha: Date?, idCatego: Int, detalles: String) {
		let gasto = Gasto(
			id: UUID(),
			idGrupo: idGrupo,
			concepto: concepto.trim(),
			cantidad: Double(cantidad)!,
			fecha: fecha ?? Date(),
			idCategoria: idCatego,
			detalles: detalles != "" ? detalles.trim() : nil
		)
		dataManager.addGasto(gasto: gasto)
		gastos = dataManager.getGastos(idGrupo: self.idGrupo)
	}

	func borrarGasto(id: UUID) {
		dataManager.deleteGasto(id: id)
		gastos = dataManager.getGastos(idGrupo: self.idGrupo)
	}
}
