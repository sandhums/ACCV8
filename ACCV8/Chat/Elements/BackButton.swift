//
//  BackButton.swift
//  ACCv5
//
//  Created by Manjinder Sandhu on 27/05/22.
//

import SwiftUI

struct BackButton: View {
    var label: String = "Back"
    
    private let spacing: CGFloat = 8
    
    var body: some View {
        HStack(spacing: spacing) {
            Image(systemName: "chevron.left")
                .aspectRatio(contentMode: .fit)
            Text(label)
        }
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(
            BackButton(label: "Fish")
                .padding()
                .previewLayout(.sizeThatFits)
        )
    }
}
