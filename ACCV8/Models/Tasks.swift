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
    @Persisted var startDate = Date()
    @Persisted var dueDate = Date()
    @Persisted var taskImage: Data?
    @Persisted var taskBackground: Data?
    @Persisted var taskLogo: Data?
    @Persisted var priority: String = ""
    @Persisted var status: String = ""
    @Persisted var progress: Double?

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
    convenience init(taskTitle: String, taskDescription: String, taskText: String, taskOwner: String, taskOwnerId: String, startDate: Date, dueDate: Date, taskImage: Data?, taskBackground: Data?, taskLogo: Data?, progress: Double?) {
        self.init()
        self.taskTitle = taskTitle
        self.taskDescription = taskDescription
        self.taskText = taskText
        self.taskOwner = taskOwner
        self.taskOwnerId = taskOwnerId
        self.startDate = startDate
        self.dueDate = dueDate
        self.taskImage = taskImage
        self.taskBackground = taskBackground
        self.taskLogo = taskLogo
        self.priorityEnum = .medium
        self.statusEnum = .notStarted
        self.progress = progress
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
