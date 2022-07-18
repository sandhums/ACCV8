//
//  LoggedInView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 29/06/22.
//

import SwiftUI
import RealmSwift

struct LoggedInView: View {
    @EnvironmentObject var model: Model
    @Environment(\.realm) var realm
    @ObservedResults(Reps.self) var users
//    @ObservedRealmObject var user: Reps
//    @State private var showingProfileView = false
   
    @AppStorage("selectedTab") var selectedTab: Tab = .centres
    @AppStorage("showAccount") var showAccount = false
    
    init() {
        showAccount = false
    }
    var body: some View {
        ZStack {
            Group {
                switch selectedTab {
                case .centres:
                    CentreListView(selectedCentre: Centre())
                       
                case .reports:
                    ReportsView()
                case .chat:
                    if let user = users.first {
                    ChatView(user: user)
                    }
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
        .sheet(isPresented: $showAccount) {
            if let user = users.first {
            AccountView(user: user)
            }
        }
        }
    }


struct LoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoggedInView()
                .preferredColorScheme(.dark)
                .environmentObject(Model())
                .previewInterfaceOrientation(.portrait)
            LoggedInView()
                .environmentObject(Model())
        }
    }
}
