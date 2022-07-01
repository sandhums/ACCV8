//
//  ACCV8App.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 28/06/22.
//

import SwiftUI
import RealmSwift

let accAppId = "accv8-vofbt"
let accApp = RealmSwift.App(id: accAppId)

@main
struct AppEntry: SwiftUI.App {
    @StateObject var model = Model()
    var body: some Scene {
        WindowGroup {
                ContentView(app: accApp)
                .environmentObject(model)
        }
    }
}
