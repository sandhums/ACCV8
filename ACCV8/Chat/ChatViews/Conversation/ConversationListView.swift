//
//  ConversationListView.swift
//  ACCv5
//
//  Created by Manjinder Sandhu on 27/05/22.
//

import SwiftUI
import RealmSwift

struct ConversationListView: View {
    @EnvironmentObject var model: Model
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
                    List {
                        ForEach(conversations, id: \.id) { conversation in
                            Button(action: {
                                self.conversation = conversation
                                showConversation.toggle()
                            }) { ConversationCardView(conversation: conversation, isPreview: isPreview) }
                               
                        }.onDelete(perform: delete)
                    }
                    .listStyle(PlainListStyle())
                    .foregroundColor(Color.black)
                    
               Spacer()
                    Button(action: { showingAddChat.toggle() }) {
                        Text("Start New Chat")
                            .foregroundColor(Color.primary)
                            .font(.body).bold()
                    }
                    .buttonStyle(.plain)
                    .disabled(showingAddChat)
                }
                 
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
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 60, trailing: 20))
            )
            
        }
        .navigationBarHidden(true)
        }
        .accentColor(.primary)
        .onAppear {
            $user.presenceState.wrappedValue = .onLine
        }
        .sheet(isPresented: $showingAddChat) {
            NewConversationView(user: user)
                .environmentObject(model)
                .environment(\.realmConfiguration, accApp.currentUser!.flexibleSyncConfiguration())
        }
    }
    func delete(at offsets: IndexSet){
        let conversations = user.conversations.sorted(by: sortDescriptors)
        for offset in offsets{
            if let index = user.conversations.firstIndex(of: conversations[offset]) {
                $user.conversations.remove(at: index)
            }
        }
    }
}


struct ConversationListViewPreviews: PreviewProvider {
    
    static var previews: some View {
        Realm.bootstrap()
        
        return ConversationListView(user: .sample, isPreview: true)
           
    }
}
