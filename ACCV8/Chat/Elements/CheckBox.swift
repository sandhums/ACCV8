//
//  CheckBox.swift
//  ACCv5
//
//  Created by Manjinder Sandhu on 27/05/22.
//

import SwiftUI

struct CheckBox: View {
    var title: String
    @Binding var isChecked: Bool

    var body: some View {
        Button(action: { self.isChecked.toggle() }) {
            HStack {
                Image(systemName: isChecked ? "checkmark.square": "square")
                Text(title)
            }
            .foregroundColor(isChecked ? .primary : .secondary)
        }
    }
}

struct CheckBox_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(
            VStack {
                CheckBox(title: "Test checkbox", isChecked: .constant(true))
                CheckBox(title: "Test checkbox", isChecked: .constant(false))
            }
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
