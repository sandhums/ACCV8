//
//  Photo.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 29/06/22.
//

import Foundation
import SwiftUI
import RealmSwift

class Photo: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var _id = UUID().uuidString
    @Persisted var thumbNail: Data?
    @Persisted var picture: Data?
    @Persisted var date = Date()
}
