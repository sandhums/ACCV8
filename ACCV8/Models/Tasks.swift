//
//  Tasks.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 29/06/22.
//

import Foundation
import RealmSwift

class Tasks: Object, ObjectKeyIdentifiable {
    @Persisted var _id: ObjectId
    @Persisted var taskTitle = ""
    @Persisted var taskDescription = ""
    @Persisted var taskOwner = ""
    @Persisted var taskOwnerId = ""
    @Persisted var startDate = Date()
    @Persisted var dueDate = Date()
    @Persisted var priority: String = ""
    @Persisted var status: String = ""

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
    var priorityEnum: TaskPriority {
            get {
                return TaskPriority(rawValue: priority) ?? .medium
            }
            set {
                priority = newValue.rawValue
            }
        }
    convenience init(taskTitle: String, taskDescription: String, taskOwner: String, taskOwnerId: String) {
        self.init()
        self.taskTitle = taskTitle
        self.taskDescription = taskDescription
        self.taskOwner = taskOwner
        self.taskOwnerId = taskOwnerId
        self.statusEnum = .notStarted
        }
}

enum TaskStatusEnum: String, PersistableEnum {
    case notStarted
    case inProgress
    case complete
    case overdue
}
enum TaskPriority: String, PersistableEnum {
  case high
  case medium
  case low
}
