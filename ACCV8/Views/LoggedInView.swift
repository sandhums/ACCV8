//
//  LoggedInView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 29/06/22.
//

import SwiftUI
import RealmSwift

struct LoggedInView: View {
    @Environment(\.realm) var realm
    @ObservedResults(Reps.self) var users
    @ObservedRealmObject var user: Reps
//    @State private var showingProfileView = false
    @State private var showTab: Bool = true
    @AppStorage("selectedTab") var selectedTab: Tab = .centres

    var body: some View {
        ZStack {
            Group {
                switch selectedTab {
                case .centres:
                    CentresView()
                case .reports:
                    ReportsView()
                case .chat:
                   ConversationListView(user: user)
                case .projects:
                    ProjectsView()
                }
            }
            .safeAreaInset(edge: .bottom) {
                VStack {}.frame(height: 44)
            }
            
            TabBar()
            

        }
        .dynamicTypeSize(.large ... .xxLarge)
        }
    }


struct LoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInView(user: Reps())
            .environmentObject(Model())
    }
}
