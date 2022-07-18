//
//  AdminView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 16/07/22.
//

import SwiftUI
import RealmSwift

struct AdminView: View {
    @Environment(\.realm) var realm
    @ObservedResults(Reps.self) var users
    var body: some View {
        NavigationView {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
