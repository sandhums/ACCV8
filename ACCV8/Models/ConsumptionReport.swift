//
//  ConsumptionReport.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 27/07/22.
//

import Foundation
import RealmSwift


class ConsumptionReport:Object, ObjectKeyIdentifiable {
    @Persisted var _id: ObjectId
    @Persisted var reportedBy = ""
    @Persisted var reportedById = ""
    @Persisted var reportOfCentre = ""
    @Persisted var reportDate = Date()
    @Persisted var consumables: List<Consumables>
    @Persisted var consumptionItems: List<ConsumptionItems>
    
    
    override static func primaryKey() -> String? {
          return "_id"
      }
    convenience init(reportedBy: String, reportedById: String, reportOfCentre: String, consumables: [Consumables], consumptionItems: [ConsumptionItems]) {
        self.init()
        self.reportedBy = reportedBy
        self.reportedById = reportedById
        self.reportOfCentre = reportOfCentre
        self.consumables.append(objectsIn: consumables)
        self.consumptionItems.append(objectsIn: consumptionItems)
        }
}
