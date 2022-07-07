//
//  ChatView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 01/07/22.
//

import SwiftUI
import RealmSwift

struct ChatView: View {
    @Environment(\.realm) var realm
  
    @ObservedRealmObject var user: Reps

    @State private var showChatView = false
    @State private var showTab: Bool = true
    var body: some View {
        VStack {
        Text("Chat")
            Button {
           showChatView = true
            } label: {
               Text ("Start Chat")
            }
   
        }
        .sheet(isPresented: $showChatView) {
            ConversationListView(user: user)
         
        }
        .onAppear {
                showChatView = true
            }
    }
   
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user: Reps())
    }
}
