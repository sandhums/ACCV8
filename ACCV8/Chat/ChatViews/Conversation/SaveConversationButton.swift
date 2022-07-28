//
//  SaveConversationButton.swift
//  ACCv5
//
//  Created by Manjinder Sandhu on 27/05/22.
//

import SwiftUI

import RealmSwift

struct SaveConversationButton: View {
    @EnvironmentObject var model: Model
    
    @ObservedRealmObject var user:Reps
    
    let name: String
    let members: [String]
    var done: () -> Void = { }
    
    var body: some View {
        Button(action: saveConversation) {
            Text("Save")
        }
    }
    
    private func saveConversation() {
//        model.error = nil
        let conversation = Conversation()
        conversation.displayName = name
        conversation.members.append(Member(userName: user.userName, state: .active))
        conversation.members.append(objectsIn: members.map { Member($0) })
        $user.conversations.append(conversation)
        done()
    }
}

struct SaveConversationButton_Previews: PreviewProvider {
    static var previews: some View {
        return AppearancePreviews(
            SaveConversationButton(
                user: .sample, name: "Example Conversation",
                members: ["rod@contoso.com", "jane@contoso.com", "freddy@contoso.com"])
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
