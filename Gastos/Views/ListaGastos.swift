//
//  ListaGastos.swift
//  Gastos
//
//  Created by Pedro Muñoz on 19/09/22.
//

import SwiftUI

struct ListaGastos: View {
	@EnvironmentObject var VM: GastosViewModel

	var body: some View {
		VStack {
			List {
				ForEach(Array(VM.agruparGastosPorMes()), id: \.key) { mes, gastos in
					Section {
						ForEach(gastos) { gasto in
							GastoRow(gasto: gasto)
							.swipeActions(edge: .trailing, allowsFullSwipe: false) {
								Button {
									VM.borrarGasto(id: gasto.id)
								} label: {
									Label("Borrar", systemImage: "trash.fill")
								}.tint(.red)
							}
						}
					} header: {
						Text(mes)
					}.listSectionSeparator(.hidden)
				}
			}.listStyle(.plain)
		}.navigationTitle("Gastos")
		.navigationBarTitleDisplayMode(.inline)
	}
}

struct ListaGastos_Previews: PreviewProvider {
	static let VM: GastosViewModel = {
		let grupo = gruposPreviewData[0]

		let VM = GastosViewModel(idGrupo: grupo.id)
		VM.gastos = gastosListPreviewData
		return VM
	}()

	static var previews: some View {
		Group {
			NavigationView {
				ListaGastos()
			}
			NavigationView {
				ListaGastos()
				.preferredColorScheme(.dark)
			}
		}.environmentObject(VM)
	}
}
