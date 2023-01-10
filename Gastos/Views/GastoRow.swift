//
//  GastoRow.swift
//  Gastos
//
//  Created by Csweb on 19/09/22.
//

import SwiftUI
import SwiftUIFontIcon

struct GastoRow: View {
	var gasto: Gasto

	var body: some View {
		HStack(spacing: 20) {
			RoundedRectangle(cornerRadius: 20).fill(Color.icon.opacity(0.3))
			.frame(width: 44, height: 44)
			.overlay {
				FontIcon.text(.awesome5Solid(code: gasto.icono), fontsize: 24, color: .icon)
			}

			VStack(alignment: .leading, spacing: 6) {
				Text(gasto.concepto)
				.font(.subheadline).bold()
				.lineLimit(1)

				Text(gasto.categoria)
				.font(.footnote)
				.opacity(0.7).lineLimit(1)

				Text(gasto.fecha, format: .dateTime.year().month().day())
				.font(.footnote).foregroundColor(.secondary)
			}

			Spacer()

			Text("$\(gasto.cantidad, specifier: "%.02f")").bold()
		}.padding([.top, .bottom], 5)
	}
}

struct GastoRow_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			GastoRow(gasto: gastoPreviewData)
			GastoRow(gasto: gastoPreviewData)
			.preferredColorScheme(.dark)
		}
	}
}
