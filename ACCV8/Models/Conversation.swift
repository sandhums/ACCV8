//
//  Conversation.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 29/06/22.
//

import Foundation
import RealmSwift

class Conversation: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var id = UUID().uuidString
    @Persisted var displayName = ""
    @Persisted var unreadCount = 0
    @Persisted var members = List<Member>()
}
