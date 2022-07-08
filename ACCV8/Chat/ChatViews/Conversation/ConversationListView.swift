//
//  ConversationListView.swift
//  ACCv5
//
//  Created by Manjinder Sandhu on 27/05/22.
//

import SwiftUI

import RealmSwift

struct ConversationListView: View {
    
//    @EnvironmentObject var state: AppState
    @ObservedRealmObject var user: Reps
    
    var isPreview = false
    
    @State private var conversation: Conversation?
    @State private var showConversation = false
    @State private var showingAddChat = false
    
    private let sortDescriptors = [
        SortDescriptor(keyPath: "unreadCount", ascending: false),
        SortDescriptor(keyPath: "displayName", ascending: true)
    ]
    
    var body: some View {
        NavigationView {
        ZStack {
            VStack {
                if let conversations = user.conversations.sorted(by: sortDescriptors) {
                    List {
                        ForEach(conversations) { conversation in
                            Button(action: {
                                self.conversation = conversation
                                showConversation.toggle()
                            }) { ConversationCardView(conversation: conversation, isPreview: isPreview) }
                        }
                        .listRowBackground(Color("Background"))
                    }
                    Button(action: { showingAddChat.toggle() }) {
                        Text("Start New Chat")
                            .foregroundColor(.black)
                    }
                    .disabled(showingAddChat)
                }
                Spacer()
                if isPreview {
                    NavigationLink(
                        destination: ChatRoomView(user: user, conversation: conversation),
                        isActive: $showConversation) { EmptyView() }
                } else {
                    NavigationLink(
                        destination: ChatRoomView(user: user, conversation: conversation),
                        isActive: $showConversation) { EmptyView() }
                }
            }
        }
        }
        .onAppear {
            $user.presenceState.wrappedValue = .onLine
        }
        .sheet(isPresented: $showingAddChat) {
            NewConversationView(user: user)
//                .environmentObject(state)
                .environment(\.realmConfiguration, accApp.currentUser!.flexibleSyncConfiguration())
        }
    }
    
}


struct ConversationListViewPreviews: PreviewProvider {
    
    static var previews: some View {
        Realm.bootstrap()
        
        return ConversationListView(user: .sample, isPreview: true)
           
    }
}
