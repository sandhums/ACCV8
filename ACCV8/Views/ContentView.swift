//
//  ContentView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 28/06/22.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @ObservedObject var app: RealmSwift.App
    @EnvironmentObject var model: Model
    
    var body: some View {
        if let user = app.currentUser {
                let config = user.flexibleSyncConfiguration(initialSubscriptions: { subs in
                    if let foundSubscriptions = subs.first(named: "userId"), let _ = subs.first(named: "allCentres") {
                            return
                        } else {
                    subs.append(
                            QuerySubscription<Reps>(name: "userId") {
                                $0._id == user.id
                                })
                    subs.append(
                            QuerySubscription<Centre>(name: "allCentres"))
                        }
                    print("appended bootstrap query userId and allCentres")
                }, rerunOnOpen: true)
            
                OpenRealmView()
                    .environment(\.realmConfiguration, config)
        } else {
            SignInView()
        }
           
}

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(app: accApp)
    }
}
