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
                .frame(width: 30, height: 30)
                .cornerRadius(10)
                .padding(6)
                .background(.ultraThinMaterial)
                .backgroundStyle(cornerRadius: 18, opacity: 0.4)
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

