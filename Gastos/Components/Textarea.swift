//
//  Textarea.swift
//  Gastos
//
//  Created by Pedro Muñoz on 21/09/22.
//

import SwiftUI

struct Textarea: UIViewRepresentable {
	@Binding var text: String

	func makeUIView(context: Context) -> UITextView {
		let view = UITextView()
		view.delegate = context.coordinator
		view.isScrollEnabled = true
		view.isEditable = true
		view.isUserInteractionEnabled = true
		return view
	}

	func updateUIView(_ uiView: UITextView, context: Context) {
		uiView.text = text
	}

	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}

	final class Coordinator: NSObject, UITextViewDelegate {
		var parent: Textarea
		init(_ uiTextView: Textarea) { parent = uiTextView }

		func textViewDidChange(_ textView: UITextView) {
			//print("text now: \(String(describing: textView.text!))")
			parent.text = textView.text
		}

		func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
			true
		}
	}
}
