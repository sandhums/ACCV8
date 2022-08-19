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
           ProgressView()
       case .waitingForUser:
           ProgressView("Waiting for user to log in...")
       case .open(let realm):
          LoggedInView()
                .environment(\.realm, realm)
       case .progress(let progress):
           ProgressView(progress)
       case .error(let error):
           ErrorView(error: error)
       }
    }
    
}
