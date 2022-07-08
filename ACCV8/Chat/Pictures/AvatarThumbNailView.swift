//
//  AvatarThumbNailView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 01/07/22.
//

import SwiftUI

struct AvatarThumbNailView: View {
    let photo: Photo
    var imageSize: CGFloat = 76
    var gradient1: [Color] = [
        Color.init(red: 101/255, green: 134/255, blue: 1),
        Color.init(red: 1, green: 64/255, blue: 80/255),
        Color.init(red: 109/255, green: 1, blue: 185/255),
        Color.init(red: 39/255, green: 232/255, blue: 1),
    ]

    @State private var angle: Double = 0
    

    private enum Dimensions {
        static let radius: CGFloat = 4
        static let iconPadding: CGFloat = 8
        static let compressionQuality: CGFloat = 0.8
    }

    var body: some View {
        ZStack {
            AngularGradient(gradient: Gradient(colors: gradient1), center: .center, angle: .degrees(angle))
                .mask(
                    Circle()
                        .frame(width: 80, height: 80, alignment: .center)
                        .blur(radius: 6.0)
                )
                .blur(radius: 6.0)
                .onAppear {
                    withAnimation(.linear(duration: 12)) {
                        self.angle += 350
                    }
                }
        VStack {
            if let photo = photo {
                ThumbNailView(photo: photo)
            } else {
                if let photo = photo.picture {
                    Thumbnail(imageData: photo)
                } else {
                    Thumbnail(imageData: UIImage().jpegData(compressionQuality: Dimensions.compressionQuality)!)
                }
            }
        }
        .frame(width: imageSize, height: imageSize, alignment: .center)
//        .cornerRadius(Dimensions.radius)
        .mask(
            Circle()
            )
        }
    }
}

struct AvatarThumbNailView_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(
            AvatarThumbNailView(photo: .sample)
                .padding()
                .previewLayout(.sizeThatFits)
        )
    }
}
