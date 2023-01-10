//
//  GruposView.swift
//  Gastos
//
//  Created by Pedro Muñoz on 22/09/22.
//

import SwiftUI

struct GruposView: View {
	@StateObject var gruposVM = GruposViewModel()
	@State private var showModal: Bool = false

	var body: some View {
		ZStack {
			NavigationView {
				VStack {
					if gruposVM.grupos.isEmpty {
						Text("No hay grupos").padding()
						.background(Color.background)
						.cornerRadius(20)
					} else {
						List(gruposVM.grupos) { grupo in
							HStack {
								NavigationLink {
									InitGrupoView(grupo: grupo)
								} label: {
									Text(grupo.nombre).foregroundColor(.text)
								}
							}.swipeActions(edge: .trailing, allowsFullSwipe: false) {
								Button {
									gruposVM.borrarGrupo(id: grupo.id)
								} label: {
									Label("Borrar", systemImage: "trash.fill")
								}.tint(.red)
							}
						}.listStyle(.plain)
					}
				}.navigationTitle("Gastos")
				.toolbar {
					ToolbarItem {
						HStack {
							//Image(systemName: "bell.badge")
							//.symbolRenderingMode(.palette)
							//.foregroundStyle(Color.icon, .primary)
							Button {
								self.showModal.toggle()
							} label: {
								Image(systemName: "plus")
								.foregroundStyle(.primary)
							}
						}
					}
				}
			}.navigationViewStyle(.stack)
			.accentColor(.primary)

			if showModal {
				ModalNewGroup(show: $showModal) { nombre in
					gruposVM.addGrupo(nombre: nombre)
				}
			}
		}
	}
}

private struct ModalNewGroup: View {
	@Binding var show: Bool
	var onCreate: (String) -> ()
	@State private var nombre: String = ""

	var body: some View {
		ZStack {
			Color.background.opacity(0.8).ignoresSafeArea()
			.onTapGesture { self.show.toggle() }

			VStack {
				VStack {
					TextField("Nombre", text: $nombre).textFieldStyle(.roundedBorder)

					HStack {
						Button("Cancelar") {
							self.show.toggle()
						}

						Spacer()

						Button {
							onCreate(nombre)
							self.show.toggle()
						} label: {
							Text("Crear").foregroundColor(.text)
						}
					}.padding(.top).padding(.horizontal)
				}.padding().padding()
				.background(Color.systemBackground)
				.cornerRadius(20)
				.padding()
				.padding(.horizontal, 50)
				.padding(.top, 150)

				Spacer()
			}
		}
	}
}

struct GruposView_Previews: PreviewProvider {
	static let VM: GruposViewModel = {
		let VM = GruposViewModel()
		VM.grupos = gruposPreviewData
		return VM
	}()

	static var previews: some View {
		Group {
			GruposView(gruposVM: VM)
			GruposView(gruposVM: VM)
			.preferredColorScheme(.dark)
		}
	}
}
