//
//  NewConversationView.swift
//  ACCv5
//
//  Created by Manjinder Sandhu on 27/05/22.
//

import SwiftUI

import RealmSwift

struct NewConversationView: View {
//    @EnvironmentObject var state: AppState
    @Environment(\.presentationMode) var presentationMode
    @ObservedResults(Chatster.self) var chatsters
    @Environment(\.realm) var realm
    
    @ObservedRealmObject var user: Reps
    
    var isPreview = false
    
    @State private var name = ""
    @State private var members = [String]()
    @State private var candidateMember = ""
    @State private var candidateMembers = [String]()
    
    private var isEmpty: Bool {
        !(name != "" && members.count > 0)
    }
    
    private var memberList: [String] {
        candidateMember == ""
            ? chatsters.compactMap {
                user.userName != $0.userName && !members.contains($0.userName)
                    ? $0.userName
                    : nil }
            : candidateMembers
    }
    
    var body: some View {
        
        let searchBinding = Binding<String>(
            get: { candidateMember },
            set: {
                candidateMember = $0
                searchUsers()
            }
        )
      
      return NavigationView {
            ZStack {
                VStack {
                    TextField("Chat Name", text: $name)
                        .customField(icon: "message")
                    Text("Add Members".uppercased())
                        .sectionTitleModifier()
                    SearchBox(searchText: searchBinding)
                    List {
                        ForEach(memberList, id: \.self) { candidateMember in
                            Button(action: { addMember(candidateMember) }) {
                                HStack {
                                    Text(candidateMember)
                                    Spacer()
                                    Image(systemName: "plus.circle.fill")
                                    .renderingMode(.original)
                                }
                            }
                        }
                       
                    }
                   
                    Divider()
                    Text("Members".uppercased())
                        .sectionTitleModifier()
                    List {
                        ForEach(members, id: \.self) { member in
                            Text(member)
                        }
                        .onDelete(perform: deleteMember)
                    }
                    Spacer()
                }
                
                Spacer()
//                if let error = state.error {
//                    Text("Error: \(error)")
//                        .foregroundColor(Color.red)
//                }
            }
            .padding()
            .navigationBarTitle("New Chat", displayMode: .inline)
            .navigationBarItems(
                leading: Button (action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    CloseButton()
                }),
                trailing:VStack {
                    if isPreview {
                        SaveConversationButton(user: user, name: name, members: members, done: { presentationMode.wrappedValue.dismiss() })
                    } else {
                        SaveConversationButton(user: user, name: name, members: members, done: { presentationMode.wrappedValue.dismiss() })
                    }
                }
            .disabled(isEmpty)
            .padding()
            )
            .background(
                Image("Background 2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
    //                .opacity(0.8)
                    .ignoresSafeArea()
                    .accessibility(hidden: true))
        }
        .onAppear {
            setSubscription()
            searchUsers()
        }
        
    }
    
    private func searchUsers() {
        var candidateChatsters: Results<Chatster>
        if candidateMember == "" {
            candidateChatsters = chatsters
        } else {
            let predicate = NSPredicate(format: "userName CONTAINS[cd] %@", candidateMember)
            candidateChatsters = chatsters.filter(predicate)
        }
        candidateMembers = []
        candidateChatsters.forEach { chatster in
            if !members.contains(chatster.userName) && chatster.userName != user.userName {
                candidateMembers.append(chatster.userName)
            }
        }
    }
    
    private func addMember(_ newMember: String) {
       
//        state.error = nil
//        if members.contains(newMember) {
//            error = "\(newMember) is already part of this chat"
//        } else {
            members.append(newMember)
            candidateMember = ""
            searchUsers()
        }
    
    
    private func deleteMember(at offsets: IndexSet) {
        members.remove(atOffsets: offsets)
    }
    
    private func setSubscription() {
        let subscriptions = realm.subscriptions
        subscriptions.update {
            if let currentSubscription = subscriptions.first(named: "all_chatsters") {
                currentSubscription.updateQuery(toType: Chatster.self) { chatster in
                    chatster.userName != ""
                }

            } else {
                subscriptions.append(QuerySubscription<Chatster>(name: "all_chatsters") { chatster in
                    chatster.userName != ""
                })
            }
        }
    }
}

struct NewConversationView_Previews: PreviewProvider {
    static var previews: some View {
        Realm.bootstrap()
        
        return AppearancePreviews(
            NewConversationView(user: .sample, isPreview: true)
               
        )
    }
}
