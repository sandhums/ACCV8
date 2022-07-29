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
    @Persisted var centreName = ""
    @Persisted var reportDate = Date()
    @Persisted var consumptionItems: List<ConsumptionItems>
    
    
    override static func primaryKey() -> String? {
          return "_id"
      }
    convenience init(reportedBy: String, reportedById: String, centreName: String, consumptionItems: [ConsumptionItems]) {
        self.init()
        self.reportedBy = reportedBy
        self.reportedById = reportedById
        self.centreName = centreName
        self.consumptionItems.append(objectsIn: consumptionItems)
        }
}
