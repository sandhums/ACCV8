//
//  AvatarButton.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 01/07/22.
//

import SwiftUI

struct AvatarButton: View {
    let photo: Photo
    let action: () -> Void
    
//    private enum Dimensions {
//        static let frameWidth: CGFloat = 40
//        static let frameHeight: CGFloat = 30
//        static let opacity = 0.9
//    }
    
    var body: some View {
        ZStack {
            Button(action: action) {
                AvatarThumbNailView(photo: photo)
            }
        }
    }
}

struct AvatarButton_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(
            AvatarButton(photo: .sample, action: {})
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

