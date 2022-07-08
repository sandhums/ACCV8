//
//  OnOffCircleView.swift
//  ACCv5
//
//  Created by Manjinder Sandhu on 27/05/22.
//

import SwiftUI

struct OnOffCircleView: View {
    let online: Bool
    
    private enum Dimensions {
        static let frameSize: CGFloat = 14.0
        static let innerCircleSize: CGFloat = 10
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(.ultraThinMaterial)
                .frame(width: Dimensions.frameSize, height: Dimensions.frameSize)
            Circle()
                .fill(online ? Color.green : Color.red)
                .frame(width: Dimensions.innerCircleSize, height: Dimensions.innerCircleSize)
        }
    }
}

struct OnOffCircleView_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(
            Group {
                OnOffCircleView(online: true)
            }
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
