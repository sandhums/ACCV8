//
//  Projects.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 29/06/22.
//

import Foundation
import RealmSwift
import MapKit

class Projects: Object, ObjectKeyIdentifiable {
    @Persisted var _id: ObjectId
    @Persisted var projectName = ""
    @Persisted var projectOwner = ""
    @Persisted var projectOwnerId = ""
    @Persisted var projectLocation: CLLocationCoordinate2D
    @Persisted var tasks: RealmSwift.List<Tasks>
    
    override static func primaryKey() -> String? {
          return "_id"
      }
    convenience init(projectName: String, projectOwner: String, projectOwnerId: String, tasks: [Tasks]) {
         self.init()
         self.projectName = projectName
         self.projectOwner = projectOwner
         self.projectOwnerId = projectOwnerId
         self.tasks.append(objectsIn: tasks)
     }
}
