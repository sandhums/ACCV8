//
//  AnnotationView.swift
//  ACCv5
//
//  Created by Manjinder Sandhu on 11/06/22.
//

import Foundation
import SwiftUI

struct AnnotationView: View {
    
    let placeName: String
    @State private var showPlaceName = true
    
    var body: some View {
        VStack(spacing: 0) {
            GradientText(text: placeName)
                    .font(.title3.bold())
                    .foregroundColor(.primary)
                    .padding(5)
//                    .background(Color.secondary)
                    .cornerRadius(10)
                    // Prevents truncation of the Text
                    .fixedSize(horizontal: true, vertical: false)
                    // Displays and hides the place name
                   // .opacity(showPlaceName ? 1 : 0)
//                    .buttonStyle(.plain)
            // You can use whatever you want here. This is a custom annotation marker
            // made to look like a standard annotation marker.
            Image(systemName: "mappin.circle.fill")
                .font(.title)
                .foregroundColor(.red)
            
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .foregroundColor(.red)
                .offset(x: 0, y: -5)
        }
//        .onTapGesture {
//            withAnimation(.easeInOut) {
//                showPlaceName.toggle()
//            }
//        }
        
    }
}
