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
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var projectName = ""
    @Persisted var projectText = ""
    @Persisted var owner_id = ""
    @Persisted var owner_id2 = ""
    @Persisted var owner_id3 = ""
    @Persisted var projectPic = ""
    @Persisted var projectBackgrnd = ""
    @Persisted var projectLogoF = ""
    @Persisted var projectLocation: CLLocationCoordinate2D
    @Persisted var tasks: List<Tasks> = List<Tasks>()
    
    override static func primaryKey() -> String? {
          return "_id"
      }
    convenience init(projectName: String, projectText: String, owner_id: String, owner_id2: String, owner_id3: String, projectPic: String, projectBackgrnd: String, projectLogoF: String, tasks: [Tasks]) {
        self.init()
        self.projectName = projectName
        self.projectText = projectText
        self.owner_id = owner_id
        self.owner_id2 = owner_id2
        self.owner_id3 = owner_id3
        self.projectPic = projectPic
        self.projectBackgrnd = projectBackgrnd
        self.projectLogoF = projectLogoF
        self.tasks.append(objectsIn: tasks)
     }
}
