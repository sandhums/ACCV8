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
    @Persisted var designation = ""
    @Persisted var userBio = ""
    @Persisted var userIndex = 0
    @Persisted var userMobile = ""
    @Persisted var centreName = ""
    @Persisted var userPreferences: UserPreferences?
    @Persisted var lastSeenAt: Date?
    @Persisted var conversations = List<Conversation>()
    @Persisted var presence = "On-Line"
    

    var isProfileSet: Bool { !(userPreferences?.isEmpty ?? true) }
    var presenceState: Presence {
        get { return Presence(rawValue: presence) ?? .hidden }
        set { presence = newValue.asString }
    }
    
    convenience init(userName: String, id: String, firstName: String, lastName: String, designation: String, userBio: String, userIndex: Int, userMobile: String, centreName: String) {
        self.init()
        self.userName = userName
        _id = id
        self.firstName = firstName
        self.lastName = lastName
        self.designation = designation
        self.userBio = userBio
        self.userIndex = userIndex
        self.userMobile = userMobile
        self.centreName = centreName
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
