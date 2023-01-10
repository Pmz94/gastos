//
//  GastosRecientes.swift
//  Gastos
//
//  Created by Pedro Muñoz on 19/09/22.
//

import SwiftUI

struct GastosRecientes: View {
	@EnvironmentObject var VM: GastosViewModel

	var body: some View {
		VStack {
			HStack {
				Text("Recientes").bold()

				Spacer()

				NavigationLink {
					ListaGastos().environmentObject(VM)
				} label: {
					HStack(spacing: 4) {
						Text("Ver todos")
						Image(systemName: "chevron.right")
					}.foregroundColor(.text)
				}
			}.padding(.top)

			ForEach(Array(VM.gastos.prefix(5).enumerated()), id: \.element) { i, gasto in
				GastoRow(gasto: gasto)

				Divider().opacity(i == 4 ? 0 : 1)
			}
		}.padding()
		.background(Color.systemBackground)
		.clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
		.shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
	}
}

struct GastosRecientes_Previews: PreviewProvider {
	static let VM: GastosViewModel = {
		let grupo = gruposPreviewData[0]

		let VM = GastosViewModel(idGrupo: grupo.id)
		VM.gastos = gastosPreviewData
		return VM
	}()

	static var previews: some View {
		Group {
			NavigationView {
				GastosRecientes()
			}
			NavigationView {
				GastosRecientes()
				.preferredColorScheme(.dark)
			}
		}.environmentObject(VM)
	}
}
