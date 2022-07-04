//
//  ChatRoomView.swift
//  ACCv5
//
//  Created by Manjinder Sandhu on 27/05/22.
//

import RealmSwift
import SwiftUI

struct ChatRoomView: View {
//    @EnvironmentObject var state: AppState
    
    @ObservedRealmObject var user: Reps
    var conversation: Conversation?
    var isPreview = false
    
    let padding: CGFloat = 8
    
    var body: some View {
        VStack {
            if let conversation = conversation {
                if isPreview {
                    ChatRoomBubblesView(user: user, conversation: conversation, isPreview: isPreview)
                } else {
                    ChatRoomBubblesView(user: user, conversation: conversation)
                        .environment(\.realmConfiguration, accApp.currentUser!.flexibleSyncConfiguration())
                }
            }
            Spacer()
        }
        .navigationBarTitle(conversation?.displayName ?? "Chat", displayMode: .inline)
        .padding(.horizontal, padding)
        .onAppear(perform: clearUnreadCount)
        .onDisappear(perform: clearUnreadCount)
    }
    
    private func clearUnreadCount() {
        if let conversationId = conversation?.id {
            if let conversationIndex = user.conversations.firstIndex(where: { $0.id == conversationId }) {
                $user.conversations[conversationIndex].unreadCount.wrappedValue = 0
            }
        }
    }
}

struct ChatRoom_Previews: PreviewProvider {
    static var previews: some View {
        Realm.bootstrap()
        
        return AppearancePreviews(
            Group {
                NavigationView {
                    ChatRoomView(user: .sample, conversation: .sample, isPreview: true)
                }
            }
        )

    }
}
