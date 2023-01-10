//
//  GrupoView.swift
//  Gastos
//
//  Created by Csweb on 19/09/22.
//

import SwiftUI
import SwiftUICharts

struct InitGrupoView: View {
	var grupo: Grupo
	@StateObject var VM: GastosViewModel

	init(grupo: Grupo) {
		self.grupo = grupo
		_VM = StateObject(wrappedValue: GastosViewModel(idGrupo: grupo.id))
	}

	var body: some View {
		GrupoView(grupo: grupo).environmentObject(VM)
		.onAppear {
			print("Pintando vista de grupo", grupo.id, grupo.nombre)
		}
	}
}

struct GrupoView: View {
	@EnvironmentObject var VM: GastosViewModel
	var grupo: Grupo
	@State private var showSheet: Bool = false

	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 24) {
				if VM.gastos.isEmpty {
					Text("No hay gastos recientes")
					.padding().background(Color.systemBackground)
					.cornerRadius(20)
				} else {
					let data = VM.totalGastos()

					if !data.isEmpty {
						CardView {
							VStack(alignment: .leading) {
								ChartLabel(
									"$\(data.reduce(0, +).roundTo2Digits())",
									type: .title,
									format: "$%.02f"
								)

								LineChart()
							}.background(Color.systemBackground)
						}
						.data(data)
						.chartStyle(ChartStyle(
							backgroundColor: .systemBackground,
							foregroundColor: ColorGradient(.icon.opacity(0.4), .icon)
						))
						.frame(height: 220)
					}

					GastosRecientes()
				}
			}.padding()
		}
		.frame(maxWidth: .infinity)
		.background(Color.background)
		.navigationTitle(grupo.nombre)
		.toolbar {
			ToolbarItem {
				Button {
					self.showSheet.toggle()
				} label: {
					Image(systemName: "plus")
					.foregroundStyle(.primary)
				}
			}
		}
		.sheet(isPresented: $showSheet) {
			NewGasto(idGrupo: grupo.id)
		}
	}
}

struct GrupoView_Previews: PreviewProvider {
	static let grupo: Grupo = gruposPreviewData[0]

	static let VM: GastosViewModel = {
		let VM = GastosViewModel(idGrupo: grupo.id)
		VM.gastos = gastosPreviewData
		return VM
	}()

	static var previews: some View {
		Group {
			NavigationView {
				GrupoView(grupo: grupo)
			}
			NavigationView {
				GrupoView(grupo: grupo)
				.preferredColorScheme(.dark)
			}
		}.environmentObject(VM)
	}
}
