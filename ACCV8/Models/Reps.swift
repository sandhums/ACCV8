//
//  Reps.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 29/06/22.
//
import Foundation
import RealmSwift

class Reps: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id = UUID().uuidString
    @Persisted var userName = ""
    @Persisted var firstName = ""
    @Persisted var lastName = ""
    @Persisted var userMobile = ""
    @Persisted var userCentre = ""
    @Persisted var userPreferences: UserPreferences?
    @Persisted var lastSeenAt: Date?
    @Persisted var conversations = List<Conversation>()
    @Persisted var presence = "On-Line"
    @Persisted var avatarImage: Data?

    var isProfileSet: Bool { !(userPreferences?.isEmpty ?? true) }
    var presenceState: Presence {
        get { return Presence(rawValue: presence) ?? .hidden }
        set { presence = newValue.asString }
    }
    
    convenience init(userName: String, firstName: String, lastName: String, userMobile: String, userCentre: String, id: String, avatarImage: Data) {
        self.init()
        self.userName = userName
        _id = id
        self.firstName = firstName
        self.lastName = lastName
        self.userMobile = userMobile
        self.userCentre = userCentre
        self.avatarImage = avatarImage
        userPreferences = UserPreferences()
        userPreferences?.displayName = userName
        presence = "On-Line"
    }
}

enum Presence: String {
    case onLine = "On-Line"
    case offLine = "Off-Line"
    case hidden = "Hidden"
    
    var asString: String {
        self.rawValue
    }
}
