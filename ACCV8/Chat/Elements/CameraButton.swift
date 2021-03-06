//
//  CameraButton.swift
//  ACCv5
//
//  Created by Manjinder Sandhu on 27/05/22.
//

import SwiftUI

struct CameraButton: View {
    let action: () -> Void
    var active = true
    
    var body: some View {
        ButtonTemplate(action: action, active: active, activeImage: "camera.fill", inactiveImage: "camera")
    }
}

struct CameraButton_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(
            Group {
                CameraButton(action: {}, active: false)
                CameraButton(action: {})
            }
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
