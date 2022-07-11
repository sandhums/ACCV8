//
//  CentreLogoView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 10/07/22.
//

import SwiftUI
import RealmSwift

struct CentreLogoView: View {
    @Environment(\.realm) var realm
    @ObservedResults(Centre.self) var centres
    var body: some View {
        Image("Logo 2")
            .resizable()
            .frame(width: 26, height: 26)
            .cornerRadius(10)
            .padding(8)
            .background(.ultraThinMaterial)
            .backgroundStyle(cornerRadius: 18, opacity: 0.4)
    }
}

struct CentreLogoView_Previews: PreviewProvider {
    static var previews: some View {
        CentreLogoView()
    }
}
