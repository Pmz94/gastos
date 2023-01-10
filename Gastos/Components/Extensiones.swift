//
//  Extensiones.swift
//  Gastos
//
//  Created by Pedro Muñoz on 19/09/22.
//

import Foundation
import SwiftUI

extension Color {
	static let background = Color("Background")
	static let icon = Color("Icon")
	static let text = Color("Text")
	static let systemBackground = Color(uiColor: .systemBackground)
}

extension DateFormatter {
	static let allNumericUSA: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "MM/dd/yyyy"
		return formatter
	}()
}

extension String {
	func trim() -> String {
		trimmingCharacters(in: .whitespacesAndNewlines)
	}
	
	func dateParsed() -> Date {
		guard let parsedDate = DateFormatter.allNumericUSA.date(from: self) else { return Date() }
		return parsedDate
	}
}

extension Date: Strideable {
	func today() -> String {
		formatted(.dateTime.month(.twoDigits).day(.twoDigits).year(.defaultDigits))
	}

	func formatted() -> String {
		formatted(.dateTime.year().month().day())
	}
}

extension Double {
	func roundTo2Digits() -> Double {
		(self * 100).rounded() / 100
	}
}
