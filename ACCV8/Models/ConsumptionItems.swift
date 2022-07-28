//
//  ConsumptionItems.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 28/07/22.
//

import Foundation
import RealmSwift

class ConsumptionItems: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var category: String?
    @Persisted var name: String?
    @Persisted var quantity: Int?
}
