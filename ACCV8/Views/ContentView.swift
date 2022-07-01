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
                    if let foundSubscriptions = subs.first(named: "user_id") {
                        print ("did nothing in bootstrap sub")
                        return
                    } else {
                        subs.append(QuerySubscription<Reps>(name: "user_id") {
                            $0._id == user.id
                        })
                        print ("appended query user-id in bootstrap sub")
                    }
                })
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
