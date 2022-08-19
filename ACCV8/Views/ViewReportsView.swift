//
//  ViewReportsView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 18/08/22.
//

import SwiftUI
import RealmSwift

struct ViewReportsView: View {
    @Environment(\.realm) var realm
    @ObservedResults(ProcedureReport.self) var procReports
    @State private var showSafari: Bool = false
    var body: some View {
        List {
            ForEach (procReports) { procReport in
                Text(procReport.centreName)
                
            }
        }
        Text("View Procedures Yesterday")
                .padding()
                .onTapGesture {
                        showSafari.toggle()
                }
                .fullScreenCover(isPresented: $showSafari, content: {
                        SFSafariViewWrapper(url: URL(string: "https://charts.mongodb.com/charts-acc-ejzzg/public/dashboards/625265b6-5d61-4d08-86b4-48eef003d16f")!)
                })
            .task {
                do {
                    try await setSubscription()
                } catch {
                    
                }
            }
    }
    private func setSubscription() async throws {
        let subscriptions = realm.subscriptions
        let foundSubscription = subscriptions.first(named: "viewReports")
        try await subscriptions.update {
            if foundSubscription != nil {
                foundSubscription!.updateQuery(toType: ViewReports.self)
                print("updating query viewReports")
            } else {
                subscriptions.append(
                    QuerySubscription<ViewReports>(name: "viewReports"))
                print("appending query viewReports")
            }
        }
    }
}

struct ViewReportsView_Previews: PreviewProvider {
    static var previews: some View {
        ViewReportsView()
    }
}
