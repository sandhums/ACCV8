//
//  CentresView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 01/07/22.
//

import SwiftUI
import RealmSwift

struct CentresView: View {
    var body: some View {
        ZStack {
            Color("background-2").ignoresSafeArea()
            VStack {
            Text("Centres!")
            }
        }
    }
}

struct CentresView_Previews: PreviewProvider {
    static var previews: some View {
        CentresView()
    }
}
