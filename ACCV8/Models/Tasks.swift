//
//  Tasks.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 29/06/22.
//

import Foundation
import RealmSwift
import SwiftUI

class Tasks: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var taskTitle = ""
    @Persisted var taskDescription = ""
    @Persisted var taskText = ""
    @Persisted var owner_id = ""
    @Persisted var owner_id2 = ""
    @Persisted var dueDate = Date()//
    @Persisted var taskLogoF = ""
    @Persisted var progressF = 0.0
    @Persisted var isCompleted: Bool = false
    @Persisted var taskPriority = TaskPriority.medium


//    @Persisted(originProperty: "tasks") var assignee: LinkingObjects<Projects>
    
    override static func primaryKey() -> String? {
          return "_id"
      }

    convenience init(taskTitle: String, taskDescription: String, taskText: String, owner_id: String, owner_id2: String, dueDate: Date, taskLogoF: String, progressF: Double, isCompleted: Bool) {
        self.init()
        self.taskTitle = taskTitle
        self.taskDescription = taskDescription
        self.taskText = taskText
        self.owner_id = owner_id
        self.owner_id2 = owner_id2
        self.dueDate = dueDate
        self.taskLogoF = taskLogoF
        self.progressF = progressF
        self.isCompleted = isCompleted
        }
}
enum TaskPriority: String, CaseIterable, PersistableEnum {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}
