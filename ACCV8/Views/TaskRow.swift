//
//  TaskRow.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 19/07/22.
//

import SwiftUI
import RealmSwift

struct TaskRow: View {
    @EnvironmentObject var model: Model
    @Environment(\.realm) var realm
    let task: Tasks
    private func priorityBackground(_ taskPriority: TaskPriority) -> Color {
           switch taskPriority {
               case .low:
                    return .gray
               case .medium:
                   return .yellow
               case .high:
                   return .red
           }
       }
//    var selected: Bool
//    let isSelected: (Bool) -> Void
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack {
            Image(task.taskLogoF)
                .resizable()
                .frame(width: 36, height: 36)
                .mask(Circle())
                .padding(12)
                .background(Color(UIColor.systemBackground).opacity(0.3))
                .mask(Circle())
                .overlay(CircularView(value: task.progressF))
//                Text ("Start: \(task.startDate.formatted(.dateTime.day().month().year()))")
//                    .font(.caption.weight(.bold))
//                    .foregroundStyle(.secondary)
//                Text ("Due: \(task.dueDate.formatted(.dateTime.day().month().year()))")
//                    .font(.caption.weight(.bold))
//                    .foregroundStyle(.secondary)
//                Text("Priority: \( task.priority)")
//                    .font(.caption.weight(.bold))
//                    .foregroundStyle(.secondary)
            }
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                Text(task.taskTitle)
                    .fontWeight(.semibold)
                    Spacer()
                    Text(task.taskPriority.rawValue)
                        .font(.caption)
                        .foregroundStyle(.primary)
                        .padding(4)
                        .frame(width: 70)
                        .background(priorityBackground(task.taskPriority))
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                }
                Text(task.taskDescription)
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)
                Text(task.taskText)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.primary)
                HStack {
                    Text ("Due: \(task.dueDate.formatted(.dateTime.day().month().year()))")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(.secondary)

//                ProgressView(value: task.progressF)
//                    .accentColor(.purple)
//                    .frame(maxWidth: 132)
                    Spacer()
                    Image(systemName: task.isCompleted ? "record.circle": "circle")
                        .font(.caption.weight(.medium))
                        .foregroundStyle(.tertiary)
                        .onTapGesture {
                            let taskToUpdate = realm.object(ofType: Tasks.self, forPrimaryKey: task._id)
                            try? realm.write {
                                taskToUpdate?.isCompleted.toggle()
                            }
                        }
                }
            }
    
            Spacer()
        }
           
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(task: Tasks())
    }
}
