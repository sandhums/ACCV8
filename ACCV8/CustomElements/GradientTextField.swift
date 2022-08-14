//
//  GradientTextField.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 02/07/22.
//

import SwiftUI

struct GradientTextfield: View {
    @Binding var editingTextfield: Bool
    @Binding var textfieldString: String
    @Binding var iconBounce: Bool
    var textfieldPlaceholder: String
    var textfieldIconString: String
    private let generator = UISelectionFeedbackGenerator()

    var body: some View {
        HStack(spacing: 12) {
            TextfieldIcon(iconName: textfieldIconString, passedImage: .constant(nil), currentlyEditing: $editingTextfield)
                .scaleEffect(iconBounce ? 1.2 : 1.0)
            TextField(textfieldPlaceholder, text: $textfieldString) { isEditing in
                generator.selectionChanged()
                editingTextfield = isEditing
                if isEditing {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                        iconBounce.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.25) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                            iconBounce.toggle()
                        }
                    }
                }
            }
//            .background(.thinMaterial)
            .foregroundColor(Color.primary.opacity(0.7))
        }
        .background(.thinMaterial)
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .circular)
                .stroke(Color.primary.opacity(0.1), lineWidth: 1)
        )

    }
}
