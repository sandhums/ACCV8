//
//  ProcedureReport.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 29/06/22.
//

import Foundation
import RealmSwift

class ProcedureReport:Object, ObjectKeyIdentifiable {
    @Persisted var _id: ObjectId
    @Persisted var reportedBy = ""
    @Persisted var reportedById = ""
    @Persisted var centreName = ""
    @Persisted var reportDate = Date()
    @Persisted var procedures: List<Procedures>
    
    
    override static func primaryKey() -> String? {
          return "_id"
      }
    convenience init(reportedBy: String, reportedById: String, reportOfCentre: String, centreName: String, procedures: [Procedures]) {
        self.init()
        self.reportedBy = reportedBy
        self.reportedById = reportedById
        self.centreName = centreName
        self.procedures.append(objectsIn: procedures)
        }
}
