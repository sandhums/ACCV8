//
//  GradientText2.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 24/07/22.
//

import SwiftUI

struct GradientText2: View {
    var text: String = "Text here"
    
    var body: some View {
        Text(text)
            .gradientForeground2(colors: [Color(#colorLiteral(red: 1, green: 0.5607843137, blue: 0.9803921569, alpha: 1)), Color(#colorLiteral(red: 0.6201313138, green: 0.6803289056, blue: 1, alpha: 1))])
            
        
    }
}

extension View {
    public func gradientForeground2(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors),
            startPoint: .topLeading, endPoint: .bottomTrailing))
        .mask(self)
    }
}


struct GradientText2_Previews: PreviewProvider {
    static var previews: some View {
        GradientText()
    }
}
