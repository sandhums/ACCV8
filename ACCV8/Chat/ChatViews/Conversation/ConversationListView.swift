//
//  ConversationListView.swift
//  ACCv5
//
//  Created by Manjinder Sandhu on 27/05/22.
//

import SwiftUI
import RealmSwift

struct ConversationListView: View {
    
    @Environment(\.presentationMode) var presentationMode
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
                Spacer()
                }
            .background(Color("Background"))
            .frame(maxWidth: .infinity)
    //        .frame(height: 500)
            .background(
                Image("background-1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
    //                .opacity(0.8)
                    .ignoresSafeArea()
                    .accessibility(hidden: true))
            .overlay (
            VStack {
                Text("Active Chats")
                    .font(.body).bold()
                if let conversations = user.conversations.sorted(by: sortDescriptors) {
                        ForEach(conversations) { conversation in
                            Button(action: {
                                self.conversation = conversation
                                showConversation.toggle()
                            }) { ConversationCardView(conversation: conversation, isPreview: isPreview) }
                            Divider()
                        }
                        .foregroundColor(Color.black)
                    
               Spacer()
                    Button(action: { showingAddChat.toggle() }) {
                        Text("Start New Chat")
                            .foregroundColor(Color.primary)
                            .font(.body).bold()
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
                .padding(20)
                .padding(.vertical, 10)
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .cornerRadius(30)
                        .blur(radius: 30)
        )
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .backgroundStyle(cornerRadius: 30)
//                        .opacity(appear[0] ? 1 : 0)
                )
                .padding(20)
            )

            Button (action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                CloseButton()
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(20)
            .ignoresSafeArea()
        }
        }
        .accentColor(.primary)
        .onAppear {
            $user.presenceState.wrappedValue = .onLine
        }
        .sheet(isPresented: $showingAddChat) {
            NewConversationView(user: user)
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
