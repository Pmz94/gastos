//
//  NewGasto.swift
//  Gastos
//
//  Created by Pedro Muñoz on 20/09/22.
//

import SwiftUI

struct NewGasto: View {
	@EnvironmentObject var vm: GastosViewModel
	@Environment(\.presentationMode) var mode: Binding<PresentationMode>
	var idGrupo: UUID
	@State private var concepto: String = ""
	@State private var cantidad: String = ""
	@State private var showAlert: Bool = false
	@State private var savedDate: Date? = nil
	@State private var showDatePicker: Bool = false
	@State private var idCategoSelecc: Int = 0
	@State private var detalles: String = ""
	@State private var showFecha: Bool = false
	@State private var showCategoria: Bool = false
	@State private var showDetalles: Bool = false

	let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd/MM/yyyy HH:mm"
		return formatter
	}()

	let cbOptions: [CBOption] = {
		var options: [CBOption] = []
		for catego in Category.all {
			options.append(CBOption(key: catego.id, value: catego.name))
		}
		return options
	}()

	var body: some View {
		VStack {
			HStack {
				Spacer()
				Button {
					mode.wrappedValue.dismiss()
				} label: {
					Text("Cancelar")
					.foregroundColor(.accentColor)
				}
			}

			VStack {
				TextField("Concepto", text: $concepto)

				TextField("Cantidad", text: $cantidad)
				.keyboardType(.decimalPad)

				if showAlert {
					Text("Diga un concepto y/o una cantidad")
					.foregroundColor(.red)
				}

				if showFecha {
					ZStack {
						ZStack(alignment: .leading) {
							RoundedRectangle(cornerRadius: 4)
							.stroke(Color.gray.opacity(0.3), lineWidth: 1)
							.frame(height: 37)
							
							if savedDate != nil {
								Text(dateFormatter.string(from: savedDate!))
								.foregroundColor(.black)
								.padding(.leading, 8)
							} else {
								Text("Fecha (opcional)")
								.foregroundColor(.gray.opacity(0.6))
								.padding(.leading, 8)
							}
						}.onTapGesture { self.showDatePicker.toggle() }
						
						if showDatePicker {
							DatePickerWithButtons(
								showDatePicker: $showDatePicker,
								savedDate: $savedDate,
								selectedDate: savedDate ?? Date()
							)
						}
					}
				} else {
					HStack {
						Text("Agregar fecha")
						Image(systemName: "plus")
					}.onTapGesture { self.showFecha.toggle() }
				}

				if showCategoria {
					ComboBox(placeholder: "Categoria (opcional)", options: cbOptions) { option in
						self.idCategoSelecc = option.key
					}
				} else {
					HStack {
						Text("Agregar categoria")
						Image(systemName: "plus")
					}.onTapGesture { self.showCategoria.toggle() }
				}

				if showDetalles {
					VStack(spacing: 5) {
						HStack {
							Text("Detalles (opcional)")
								.font(.system(size: 16))
								.foregroundColor(.gray.opacity(0.7))
							Spacer()
						}
						
						Textarea(text: $detalles).frame(maxHeight: 150)
							.overlay {
								RoundedRectangle(cornerRadius: 4)
									.stroke(Color.gray.opacity(0.3), lineWidth: 1)
							}
					}
				} else {
					HStack {
						Text("Agregar descripcion")
						Image(systemName: "plus")
					}.onTapGesture { self.showDetalles.toggle() }
				}
			}.textFieldStyle(.roundedBorder)
			.padding(.horizontal, 70)
			.zIndex(1)

			Button {
				if showAlert {
					self.showAlert.toggle()
				}

				if concepto != "" || cantidad != "" {
					vm.addGasto(
						idGrupo: idGrupo,
						concepto: concepto,
						cantidad: cantidad,
						fecha: savedDate,
						idCatego: idCategoSelecc,
						detalles: detalles
					)
					mode.wrappedValue.dismiss()
				} else {
					self.showAlert.toggle()
				}
			} label: {
				Text("Guardar").foregroundColor(.text)
			}.padding(.top, 10)

			Spacer()
		}.padding()
	}
}

private struct DatePickerWithButtons: View {
	@Binding var showDatePicker: Bool
	@Binding var savedDate: Date?
	@State var selectedDate: Date = Date()

	var body: some View {
		ZStack {
			VStack {
				DatePicker(
					"Fecha",
					selection: $selectedDate,
					displayedComponents: [.date, .hourAndMinute]
				)

				Divider()

				HStack {
					Button {
						self.showDatePicker = false
					} label: {
						Text("Cancelar").foregroundColor(.text)
					}

					Spacer()

					Button {
						self.savedDate = selectedDate
						self.showDatePicker = false
					} label: {
						Text("Aceptar").foregroundColor(.text).bold()
					}
				}.padding(.horizontal)
			}.padding()
			.background(
				Color.background.cornerRadius(10)
				.shadow(color: .gray, radius: 1, x: 0, y: 0)
			)
		}
	}
}

struct NewGasto_Previews: PreviewProvider {
	static let grupo = gruposPreviewData[0]

	static let VM: GastosViewModel = {
		let VM = GastosViewModel(idGrupo: grupo.id)
		VM.gastos = gastosListPreviewData
		return VM
	}()

	static var previews: some View {
		Group {
			NewGasto(idGrupo: grupo.id)
			NewGasto(idGrupo: grupo.id)
			.preferredColorScheme(.dark)
		}.environmentObject(VM)
	}
}
