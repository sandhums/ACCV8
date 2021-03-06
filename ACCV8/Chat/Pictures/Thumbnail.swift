//
//  Thumbnail.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 01/07/22.
//

import UIKit
import SwiftUI

struct Thumbnail: View {
    let imageData: Data
    
    var body: some View {
        Image(uiImage: (UIImage(data: imageData) ?? UIImage()))
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

struct Thumbnail_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(
            Thumbnail(imageData: (UIImage(named: "mugShotThumb") ?? UIImage()).jpegData(compressionQuality: 0.8)!)
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

