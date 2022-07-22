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
    @Persisted var _id: ObjectId
    @Persisted var taskTitle = ""
    @Persisted var taskDescription = ""
    @Persisted var taskText = ""
    @Persisted var taskOwner = ""
    @Persisted var taskOwnerId = ""
    @Persisted var startDate = Date()//
    @Persisted var dueDate = Date()//
    @Persisted var taskLogo: Data?//
    @Persisted var taskLogoF = ""
    @Persisted var priority = ""
    @Persisted var status = ""
    @Persisted var progress: Double?
    @Persisted var progressF = 0.0
    @Persisted var isCompleted: Bool = false
    @Persisted var taskPriority = TaskPriority.medium


    @Persisted(originProperty: "tasks") var assignee: LinkingObjects<Projects>
    
    override static func primaryKey() -> String? {
          return "_id"
      }
    var statusEnum: TaskStatusEnum {
            get {
                return TaskStatusEnum(rawValue: status) ?? .notStarted
            }
            set {
                status = newValue.rawValue
            }
        }
//    var priorityEnum: TaskPriority {
//            get {
//                return TaskPriority(rawValue: priority) ?? .medium
//            }
//            set {
//                priority = newValue.rawValue
//            }
//        }
    convenience init(taskTitle: String, taskDescription: String, taskText: String, taskOwner: String, taskOwnerId: String, startDate: Date, dueDate: Date, taskLogo: Data?, taskLogoF: String, priority: String, status: String, progress: Double?, progressF: Double, isCompleted: Bool) {
        self.init()
        self.taskTitle = taskTitle
        self.taskDescription = taskDescription
        self.taskText = taskText
        self.taskOwner = taskOwner
        self.taskOwnerId = taskOwnerId
        self.startDate = startDate
        self.dueDate = dueDate
        self.taskLogo = taskLogo
        self.taskLogoF = taskLogoF
        self.priority = priority
        self.status = status
        self.progress = progress
        self.progressF = progressF
        self.isCompleted = isCompleted
        }
}

enum TaskStatusEnum: String, PersistableEnum {
    case notStarted
    case inProgress
    case complete
    case overdue
}
//enum TaskPriority: String, PersistableEnum {
//  case high
//  case medium
//  case low
//}
enum TaskPriority: String, CaseIterable, PersistableEnum {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}
