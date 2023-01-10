//
//  Category.swift
//  Gastos
//
//  Created by Csweb on 21/09/22.
//

import Foundation
import SwiftUIFontIcon

struct Category {
	let id: Int
	let name: String
	let icon: FontAwesomeCode
	var mainCategoryId: Int?
}

extension Category {
	static let autoAndTransport = Category(id: 1, name: "Carro o Transporte", icon: .car_alt)
	static let billsAndUtilities = Category(id: 2, name: "Deudas y necesidades", icon: .file_invoice_dollar)
	static let entertainment = Category(id: 3, name: "Entretenimiento", icon: .film)
	static let feesAndCharges = Category(id: 4, name: "Cargos y Comisiones", icon: .hand_holding_usd)
	static let foodAndDining = Category(id: 5, name: "Comida", icon: .hamburger)
	static let home = Category(id: 6, name: "Hogar", icon: .home)
	static let income = Category(id: 7, name: "Ingreso", icon: .dollar_sign)
	static let shopping = Category(id: 8, name: "Compras", icon: .shopping_cart)
	static let transfer = Category(id: 9, name: "Transferencia", icon: .exchange_alt)

	static let publicTransportation = Category(id: 101, name: "Transporte publico", icon: .bus, mainCategoryId: 1)
	static let taxi = Category(id: 102, name: "Taxi", icon: .taxi, mainCategoryId: 1)
	static let mobilePhone = Category(id: 201, name: "Plan telefonico", icon: .mobile_alt, mainCategoryId: 2)
	static let moviesAndDVDs = Category(id: 301, name: "Peliculas", icon: .film, mainCategoryId: 3)
	static let bankFee = Category(id: 401, name: "Comision del banco", icon: .hand_holding_usd, mainCategoryId: 4)
	static let financeCharge = Category(id: 402, name: "Cargo financiero", icon: .hand_holding_usd, mainCategoryId: 4)
	static let groceries = Category(id: 501, name: "Mandado", icon: .shopping_basket, mainCategoryId: 5)
	static let restaurants = Category(id: 502, name: "Restaurantes", icon: .utensils, mainCategoryId: 5)
	static let rent = Category(id: 601, name: "Renta", icon: .house_user, mainCategoryId: 6)
	static let homeSupplies = Category(id: 602, name: "Cosas para la casa", icon: .lightbulb, mainCategoryId: 6)
	static let paycheque = Category(id: 701, name: "Nomina", icon: .dollar_sign, mainCategoryId: 7)
	static let software = Category(id: 801, name: "Juegos", icon: .icons, mainCategoryId: 8)
	static let creditCardPayment = Category(id: 901, name: "Pago de tarjeta", icon: .exchange_alt, mainCategoryId: 9)

	static let categories: [Category] = [
		.autoAndTransport,
		.billsAndUtilities,
		.entertainment,
		.feesAndCharges,
		.foodAndDining,
		.home,
		.income,
		.shopping,
		.transfer
	]

	static let subCategories: [Category] = [
		.publicTransportation,
		.taxi,
		.mobilePhone,
		.moviesAndDVDs,
		.bankFee,
		.financeCharge,
		.groceries,
		.restaurants,
		.rent,
		.homeSupplies,
		.paycheque,
		.software,
		.creditCardPayment
	]

	static let all: [Category] = categories + subCategories
}
