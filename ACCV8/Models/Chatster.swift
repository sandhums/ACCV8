//
//  Chatster.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 29/06/22.
//

import Foundation
import RealmSwift

class Chatster: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id = UUID().uuidString // This will match the _id of the associated User
    @Persisted var userName = ""
    @Persisted var firstName = ""
    @Persisted var lastName = ""
    @Persisted var designation = ""
    @Persisted var userBio = ""
    @Persisted var userIndex = 0
    @Persisted var userMobile = ""
    @Persisted var userCentre = ""
    @Persisted var displayName: String?
    @Persisted var avatarImage: Photo?
    @Persisted var lastSeenAt: Date?
    @Persisted var presence = "Off-Line"
    
    var presenceState: Presence {
        get { return Presence(rawValue: presence) ?? .hidden }
        set { presence = newValue.asString }
    }
}
