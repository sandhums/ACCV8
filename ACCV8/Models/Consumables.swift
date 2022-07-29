//
//  Consumables.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 28/07/22.
//

import Foundation
import RealmSwift

class Consumables: Object, ObjectKeyIdentifiable {
    @Persisted var _id: ObjectId
    @Persisted var category = ""
    @Persisted var name = ""

    override static func primaryKey() -> String? {
          return "_id"
      }
}
