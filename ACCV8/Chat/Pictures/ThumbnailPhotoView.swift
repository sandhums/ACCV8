//
//  ThumbnailPhotoView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 01/07/22.
//

import SwiftUI

struct ThumbnailPhotoView: View {
    let photo: Photo
    var imageSize: CGFloat = 70
    
    var body: some View {
        if let photo = photo.thumbNail {
            let mugShot = UIImage(data: photo)
            Image(uiImage: mugShot ?? UIImage())
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: imageSize, height: imageSize)
                .overlay {
                    Circle().stroke(.white, lineWidth: 2)
                           }
                           .shadow(radius: 7)
        }
    }
}

struct ThumbnailPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(ThumbnailPhotoView(photo: .sample))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

