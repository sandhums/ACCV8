//
//  LoggedInView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 29/06/22.
//

import SwiftUI
import RealmSwift

struct LoggedInView: View {
    var leadingBarButton: AnyView?
    var body: some View {
        NavigationView {
            VStack {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        }
        .navigationBarItems(leading: self.leadingBarButton)
    }
}

struct LoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInView()
    }
}
