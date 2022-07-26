//
//  UserAvatarViewNoCircle.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 26/07/22.
//

import SwiftUI

struct UserAvatarViewNoCircle: View {
    let photo: Photo?
    

    
    private enum Dimensions {
        static let imageSize: CGFloat = 30
        static let buttonSize: CGFloat = 36
        static let cornerRadius: CGFloat = 50.0
    }
    
    var body: some View {
            ZStack {
                image
            }
        .frame(width: Dimensions.buttonSize, height: Dimensions.buttonSize)
    }
    
    var image: some View {
        Group<AnyView> {
            if let image = photo {
                return AnyView(ThumbnailPhotoView(photo: image, imageSize: Dimensions.imageSize))
            } else {
                return AnyView(LogoView(image: "Avatar Default"))
            }
        }
    }
}


struct UserAvatarViewNoCircle_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(
            UserAvatarViewNoCircle(photo: .sample)
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
