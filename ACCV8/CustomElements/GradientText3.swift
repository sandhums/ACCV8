//
//  GradientText3.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 14/08/22.
//

import SwiftUI

struct GradientText3: View {
    var text: String = "Text here"
    
    var body: some View {
        Text(text)
            .gradientForeground3(colors: [Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)), Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))])
            .shadow(radius: 10)
            
        
    }
}

extension View {
    public func gradientForeground3(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors),
            startPoint: .topLeading, endPoint: .bottomTrailing))
        .mask(self)
    }
}
