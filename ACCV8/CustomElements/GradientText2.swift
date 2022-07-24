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
            .gradientForeground2(colors: [Color(#colorLiteral(red: 0.1702193916, green: 0.01387358829, blue: 0.6049716473, alpha: 1)), Color(#colorLiteral(red: 0.7609714866, green: 0.3232724369, blue: 0.6690420508, alpha: 1))])
            
        
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
