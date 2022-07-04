//
//  BlankPersonIconView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 01/07/22.
//

import SwiftUI

struct BlankPersonIconView: View {
    var body: some View {
        Image("BlankProfile")
            .resizable()
            .foregroundColor(.gray)
    }
}

struct PersonIconView_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(
            BlankPersonIconView()
                .frame(width: 50, height: 50)
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

