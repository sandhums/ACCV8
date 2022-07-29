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
    @Persisted var projectText = ""
    @Persisted var projectOwner = ""
    @Persisted var projectOwnerId = ""
    @Persisted var projectAdmin = ""
    @Persisted var projectImage: Data?
    @Persisted var projectBackgrnd = ""
    @Persisted var projectLogoF = ""
    @Persisted var projectLocation: CLLocationCoordinate2D
    @Persisted var tasks: RealmSwift.List<Tasks>
    
    override static func primaryKey() -> String? {
          return "_id"
      }
    convenience init(projectName: String, projectText: String, projectOwner: String, projectOwnerId: String, projectAdmin: String, projectImage: Data?,  projectBackgrnd: String, projectLogoF: String, tasks: [Tasks]) {
        self.init()
        self.projectName = projectName
        self.projectText = projectText
        self.projectOwner = projectOwner
        self.projectOwnerId = projectOwnerId
        self.projectAdmin = projectAdmin
        self.projectImage = projectImage
        self.projectBackgrnd = projectBackgrnd
        self.projectLogoF = projectLogoF
        self.tasks.append(objectsIn: tasks)
     }
}
