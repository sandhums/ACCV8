//
//  Procedures.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 29/06/22.
//

import Foundation
import RealmSwift

class Procedures: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var procName: String?
    @Persisted var procQty: Int?
}
