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
    
    var body: some View {
        if let user = app.currentUser {
                let config = user.flexibleSyncConfiguration(initialSubscriptions: { subs in
                    if let foundSubscriptions = subs.first(named: "userId") {
                            return
                        } else {
                    subs.append(
                            QuerySubscription<Reps>(name: "userId") {
                                $0._id == user.id
                                })
                        }
                    print("appended bootstrap query userId")
                }, rerunOnOpen: true)
            
                OpenRealmView()
                    .environment(\.realmConfiguration, config)
        } else {
            SignUpView()
        }
}
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(app: accApp)
    }
}
