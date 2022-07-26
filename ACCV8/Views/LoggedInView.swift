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
    @AppStorage("shouldRemindOnlineUser") var shouldRemindOnlineUser = false
    @AppStorage("onlineUserReminderHours") var onlineUserReminderHours = 8.0
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
                    ConversationListView(user: user)
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
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            if shouldRemindOnlineUser {
                    addNotification(timeInHours: Int(onlineUserReminderHours))
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            clearNotifications()
        }
        }
    func addNotification(timeInHours: Int) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Still logged in"
            content.subtitle = "You've been offline in the background for " +
                "\(onlineUserReminderHours) \(onlineUserReminderHours == 1 ? "hour" : "hours")"
            content.sound = UNNotificationSound.default

            let trigger = UNTimeIntervalNotificationTrigger(
                timeInterval: onlineUserReminderHours * 3600,
                repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString,
                                                content: content,
                                                trigger: trigger)
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, _ in
                    if success {
                        addRequest()
                    }
                }
            }
        }
    }

    func clearNotifications() {
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
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
