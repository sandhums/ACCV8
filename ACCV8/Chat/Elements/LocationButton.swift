//
//  LocationButton.swift
//  ACCv5
//
//  Created by Manjinder Sandhu on 27/05/22.
//

import SwiftUI

struct LocationButton: View {
    let action: () -> Void
    var active = true
    
    var body: some View {
        ButtonTemplate(action: action, active: active, activeImage: "location.fill", inactiveImage: "location")
    }
}

struct LocationButton_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(
            Group {
                LocationButton(action: {}, active: false)
                LocationButton(action: {})
            }
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
