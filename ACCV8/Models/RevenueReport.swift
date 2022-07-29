//
//  RevenueReport.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 29/06/22.
//

import Foundation
import RealmSwift

class RevenueReport: Object, ObjectKeyIdentifiable {
    @Persisted var _id: ObjectId
    @Persisted var revenueReportedBy = ""
    @Persisted var revenueReportedById = ""
    @Persisted var centreName = ""
    @Persisted var revenueDate = Date()
    @Persisted var revenueIPD: Double?
    @Persisted var revenueOPD: Double?
    @Persisted var revenueTot: Double?
    @Persisted var collectAmt: Double?
    
    override static func primaryKey() -> String? {
          return "_id"
      }
    convenience init(revenueReportedBy: String, revenueReportedById: String, centreName: String, revenueIPD: Double?, revenueOPD: Double?, revenueTot: Double?, collectAmt: Double?) {
        self.init()
        self.revenueReportedBy = revenueReportedBy
        self.revenueReportedById = revenueReportedById
        self.centreName = centreName
        self.revenueIPD = revenueIPD
        self.revenueOPD = revenueOPD
        self.revenueTot = revenueTot
        self.collectAmt = collectAmt
        }
}
