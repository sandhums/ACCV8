//
//  OpenRealmView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 29/06/22.
//

import SwiftUI
import RealmSwift

struct OpenRealmView: View {
    @AsyncOpen(appId: accAppId, timeout: 4000) var asyncOpen
    @EnvironmentObject var model: Model
       
    var body: some View {
       switch asyncOpen {
       case .connecting:
           ekgProgress()
       case .waitingForUser:
           ekgProgress(message: "Waiting for user to log in...")
       case .open(let realm):
          LoggedInView()
                .environment(\.realm, realm)
       case .progress:
           ekgProgress(message: "Opening Realm Database...")
       case .error(let error):
           ErrorView(error: error)
       }
    }
    
}
