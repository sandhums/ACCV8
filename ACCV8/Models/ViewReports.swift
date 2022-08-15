//
//  ViewReports.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 15/08/22.
//

import Foundation
import RealmSwift

class ViewReports: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var procedureRep: ProcedureReport?
    @Persisted var revenueRep: RevenueReport?
    @Persisted var consumptionRep: ConsumptionReport?
    
    override static func primaryKey() -> String? {
          return "_id"
      }
}
