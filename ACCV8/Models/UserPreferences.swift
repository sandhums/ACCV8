//
//  UserPreferences.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 29/06/22.
//

import Foundation
import RealmSwift

class UserPreferences: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var displayName: String?
    @Persisted var avatarImage: Photo?

    var isEmpty: Bool { displayName == nil || displayName == "" }
}
