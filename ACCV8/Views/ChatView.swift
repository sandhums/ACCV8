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
    @State var contentHasScrolled = false
    @State private var showChatView = false
    @State private var showTab: Bool = true
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
        ScrollView {
            scrollDetection
 
        VStack {
            Rectangle()
                .frame(width: 100, height: 72)
                .opacity(0)
        Text("Chat")
            Button {
           showChatView = true
            } label: {
               Text ("Start Chat")
            }
   
        }}
        .background(Image("Blob 1").offset(x: -50, y: -400))
        }
        .sheet(isPresented: $showChatView) {
            ConversationListView(user: user)
         
        }
        .onAppear {
                showChatView = true
            }
        .overlay(NavigationBar(title: "Chat", contentHasScrolled: $contentHasScrolled))
    }
    var scrollDetection: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scroll")).minY
            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
        }
        .onPreferenceChange(ScrollPreferenceKey.self) { offset in
            withAnimation(.easeInOut) {
                if offset < 0 {
                    contentHasScrolled = true
                } else {
                    contentHasScrolled = false
                }
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user: Reps())
    }
}
