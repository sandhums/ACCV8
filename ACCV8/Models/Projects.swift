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
    @Persisted var projectImage: Data?
    @Persisted var projectBackground: Data?
    @Persisted var projectLogo: Data?
    @Persisted var projectLocation: CLLocationCoordinate2D
    @Persisted var tasks: RealmSwift.List<Tasks>
    
    override static func primaryKey() -> String? {
          return "_id"
      }
    convenience init(projectName: String, projectText: String, projectOwner: String, projectOwnerId: String, projectImage: Data?, projectBackground: Data?, projectLogo: Data?, tasks: [Tasks]) {
        self.init()
        self.projectName = projectName
        self.projectText = projectText
        self.projectOwner = projectOwner
        self.projectOwnerId = projectOwnerId
        self.projectImage = projectImage
        self.projectBackground = projectBackground
        self.projectLogo = projectLogo
        self.tasks.append(objectsIn: tasks)
     }
}
