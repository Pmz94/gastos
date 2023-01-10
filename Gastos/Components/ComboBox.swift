//
//  ComboBox.swift
//  Gastos
//
//  Created by Csweb on 20/09/22.
//

import SwiftUI

struct CBOption: Hashable {
	let key: Int
	let value: String

	public static func ==(lhs: CBOption, rhs: CBOption) -> Bool {
		lhs.key == rhs.key
	}
}

struct ComboBox: View {
	var placeholder: String
	var options: [CBOption]
	var onOptionSelected: ((_ option: CBOption) -> Void)?
	private let buttonHeight: CGFloat = 45
	@State private var showDropdown = false
	@State private var selectedOption: CBOption? = nil

	var body: some View {
		Button {
			self.showDropdown.toggle()
		} label: {
			HStack {
				Text(selectedOption == nil ? placeholder : selectedOption!.value)
				.multilineTextAlignment(.leading)
				.foregroundColor(selectedOption == nil ? Color.gray.opacity(0.6) : Color.black)

				Spacer()

				Image(systemName: showDropdown ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
				.resizable().frame(width: 10, height: 6)
				.foregroundColor(Color.black)
			}
		}
		.padding(.leading, 8).padding(.trailing)
		.cornerRadius(5)
		.frame(width: nil, height: buttonHeight)
		.overlay {
			RoundedRectangle(cornerRadius: 5)
			.stroke(Color.gray.opacity(0.3), lineWidth: 1)
		}
		.overlay(
			VStack {
				if showDropdown {
					Spacer(minLength: buttonHeight + 2)

					Dropdown(options: options) { option in
						self.showDropdown = false
						self.selectedOption = option
						onOptionSelected?(option)
					}
				}
			}, alignment: .topLeading
		)
		.background(RoundedRectangle(cornerRadius: 5).fill(Color.white))
		.zIndex(1)
	}
}

private struct Dropdown: View {
	var options: [CBOption]
	var onOptionSelected: ((_ option: CBOption) -> Void)?

	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 0) {
				ForEach(options, id: \.self) { option in
					DropdownRow(option: option, onOptionSelected: onOptionSelected)
				}
			}.padding(.vertical, 3)
		}.frame(height: 150)
		.background(Color.white)
		.cornerRadius(5)
		.overlay {
			RoundedRectangle(cornerRadius: 5)
			.stroke(Color.gray.opacity(0.6), lineWidth: 1)
		}
	}
}

private struct DropdownRow: View {
	var option: CBOption
	var onOptionSelected: ((_ option: CBOption) -> Void)?

	var body: some View {
		Button {
			if let onOptionSelected = onOptionSelected {
				onOptionSelected(option)
			}
		} label: {
			HStack {
				Text(option.value)
				.multilineTextAlignment(.leading)
				.foregroundColor(Color.black)

				Spacer()
			}
		}
		.padding(.horizontal, 10)
		.padding(.vertical, 5)
	}
}

struct ComboBox_Previews: PreviewProvider {
	static let options: [CBOption] = [
		CBOption(key: 1, value: "Sunday"),
		CBOption(key: 2, value: "Monday"),
		CBOption(key: 3, value: "Tuesday"),
		CBOption(key: 4, value: "Wednesday"),
		CBOption(key: 5, value: "Thursday"),
		CBOption(key: 6, value: "Friday"),
		CBOption(key: 7, value: "Saturday")
	]

	static var opciones: [CBOption] {
		var options: [CBOption] = []
		for catego in Category.all {
			options.append(CBOption(key: catego.id, value: catego.name))
		}
		return options
	}

	static var previews: some View {
		Group {
			ComboBox(
				placeholder: "Categoria",
				options: opciones
			) { option in
				print(option)
			}
			ComboBox(
				placeholder: "Categoria",
				options: opciones
			) { option in
				print(option)
			}.preferredColorScheme(.dark)
		}
	}
}
