//
//  PostLoginView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 03/07/22.
//

import SwiftUI
import RealmSwift
import UserNotifications

struct PostLoginView: View {
    @Environment(\.realm) var realm
    @ObservedResults(Reps.self) var users
    @ObservedRealmObject var user: Reps
//    @Binding var userID: String?
    @State private var showingProfileView = false
    @AppStorage("shouldRemindOnlineUser") var shouldRemindOnlineUser = false
    @AppStorage("onlineUserReminderHours") var onlineUserReminderHours = 8.0
    @EnvironmentObject var model: Model
    var body: some View {
        NavigationView {
        VStack {
            if let user = users.first {
                if showingProfileView {
                   AccountView(user: user)
                } else {
                    LoggedInView()
                        .environmentObject(model)
                        .navigationBarItems(
                            leading: LogoutButton(user: user),
                            trailing:  UserAvatarView(
                                photo: user.userPreferences?.avatarImage,
                                online: true) )
                }
            }
        }
//        .onAppear(perform: getProfile)
//        .task {
//            do {
//           try await setSubsUserId()
//            } catch {
//                print ("Error")
//        }
//        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            if shouldRemindOnlineUser {
                    addNotification(timeInHours: Int(onlineUserReminderHours))
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            clearNotifications()
        }
//            navigationBarTitleDisplayMode(.inline)
    }
    }
        func setSubsUserId () async throws {
            let user = accApp.currentUser
            let subscriptions = realm.subscriptions
            let foundSubscription = subscriptions.first(named: "user_id")
            try await subscriptions.update {
                if foundSubscription != nil {
                    foundSubscription!.updateQuery(toType: Reps.self, where: {
                        $0._id == user!.id
                    })
                    print("updating subscription for user_id")
                } else {
                    subscriptions.append(
                        QuerySubscription<Reps>(name: "user_id") {
                            $0._id == user!.id
                       })
                    print("appending subscription for user_id")
                }
            }
        }
    func getProfile() {
        if let user = users.first {
            if user.isProfileSet {
                print("profile set")
                showingProfileView = false
            } else {
                print("profile not set")
                showingProfileView = true
            }
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

struct PostLoginView_Previews: PreviewProvider {
    static var previews: some View {
        PostLoginView(user: Reps())
    }
}

