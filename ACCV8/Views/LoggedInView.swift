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
    @State private var selectedTab: Tab = .centres
    
    var leadingBarButton: AnyView?
    var body: some View {
        ZStack {
            Group {
                switch selectedTab {
                case .centres:
                    CentresView()
                case .reports:
                    ReportsView()
                case .chat:
                    ChatView()
                case .projects:
                    ProjectsView()
                }
            }
            .safeAreaInset(edge: .bottom) {
                VStack {}.frame(height: 44)
            }
            
            TabBar()
            
//            if model.showModal {
//                ModalView()
//                    .accessibilityIdentifier("Identifier")
//            }
        }
    }
}

struct LoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInView()
            .environmentObject(Model())
    }
}
