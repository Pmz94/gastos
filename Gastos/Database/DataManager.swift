//
//  CoreDataManager.swift
//  Gastos
//
//  Created by Csweb on 20/09/22.
//

import Foundation
import CoreData

class DataManager: ObservableObject {
	let container = NSPersistentContainer(name: "Database")

	init() {
		container.loadPersistentStores { description, error in
			if let error = error {
				print("Error al cargar el CoreData: \(error.localizedDescription)")
			}
		}
	}

	var mainContext: NSManagedObjectContext {
		container.viewContext
	}

	func backgroundContext() -> NSManagedObjectContext {
		container.newBackgroundContext()
	}

	// Grupos
	func addGrupo(grupo: Grupo) {
		do {
			let grupoBD = GrupoBD(context: mainContext)
			grupoBD.id = UUID()
			grupoBD.nombre = grupo.nombre
			grupoBD.descripcion = grupo.descripcion
			grupoBD.fechaCreacion = Date()

			print("Agregando grupo \(grupo.nombre) con ID \(grupoBD.id!)")
			try mainContext.save()
		} catch {
			print("Error al guardar el grupo:", error.localizedDescription)
		}
	}

	func getGrupos() -> [Grupo] {
		let request = NSFetchRequest<GrupoBD>(entityName: "GrupoBD")
		request.returnsObjectsAsFaults = false

		let sort = NSSortDescriptor(key: #keyPath(GrupoBD.fechaCreacion), ascending: false)
		request.sortDescriptors = [sort]

		do {
			let result = try mainContext.fetch(request)

			var grupos: [Grupo] = []

			for data in result {
				let id = data.value(forKey: "id") as! UUID
				let nombre = data.value(forKey: "nombre") as! String
				let descripcion = data.value(forKey: "descripcion") as! String?

				grupos.append(Grupo(
					id: id,
					nombre: nombre,
					descripcion: descripcion
				))
			}

			return grupos
		} catch {
			print("Error al obtener los grupos: \(error.localizedDescription)")
			return []
		}
	}

	func borrarGrupo(id: UUID) {
		let request = NSFetchRequest<GrupoBD>(entityName: "GrupoBD")
		request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

		do {
			let result = try mainContext.fetch(request)

			for grupo in result {
				for gasto in getGastos(idGrupo: id) {
					deleteGasto(id: gasto.id)
				}
				print("Borrando grupo de ID \(id): \(grupo.value(forKey: "nombre") as! String)")
				mainContext.delete(grupo)
			}

			try mainContext.save()
		} catch {
			print("Error al borrar grupo: \(error.localizedDescription)")
		}
	}

	// Gastos
	func addGasto(gasto: Gasto) {
		do {
			let gastoBD = GastoBD(context: mainContext)
			gastoBD.id = UUID()
			gastoBD.idGrupo = gasto.idGrupo
			gastoBD.concepto = gasto.concepto
			gastoBD.cantidad = gasto.cantidad
			gastoBD.fecha = gasto.fecha
			gastoBD.idCategoria = Int32(gasto.idCategoria)
			gastoBD.detalles = gasto.detalles

			try mainContext.save()
		} catch {
			print("Error al guardar el gasto:", error.localizedDescription)
		}
	}

	func getGastos(idGrupo: UUID) -> [Gasto] {
		print("Obteniendo gastos de", idGrupo)
		let request = NSFetchRequest<GastoBD>(entityName: "GastoBD")
		request.predicate = NSPredicate(format: "idGrupo = %@", idGrupo as CVarArg)
		request.returnsObjectsAsFaults = false

		let sort = NSSortDescriptor(key: #keyPath(GastoBD.fecha), ascending: false)
		request.sortDescriptors = [sort]

		do {
			let result = try mainContext.fetch(request)

			var gastos: [Gasto] = []

			for data in result {
				let id = data.value(forKey: "id") as! UUID
				let idGrupo = data.value(forKey: "idGrupo") as! UUID
				let concepto = data.value(forKey: "concepto") as! String
				let cantidad = data.value(forKey: "cantidad") as! Double
				let fecha = data.value(forKey: "fecha") as! Date
				let idCategoria = data.value(forKey: "idCategoria") as! Int
				let detalles = data.value(forKey: "detalles") as! String?

				let gasto = Gasto(
					id: id,
					idGrupo: idGrupo,
					concepto: concepto,
					cantidad: cantidad,
					fecha: fecha,
					idCategoria: idCategoria,
					detalles: detalles
				)
				print(gasto)
				gastos.append(gasto)
			}

			return gastos
		} catch {
			print("Error al obtener los gastos: \(error.localizedDescription)")
			return []
		}
	}

	func deleteGasto(id: UUID) {
		let request = NSFetchRequest<GastoBD>(entityName: "GastoBD")
		request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

		do {
			let result = try mainContext.fetch(request)

			for object in result {
				print("Borrando gasto de ID \(id): \(object.value(forKey: "concepto") as! String)")
				mainContext.delete(object)
			}

			try mainContext.save()
		} catch {
			print("Error al borrar el gasto: \(error.localizedDescription)")
		}
	}
}
