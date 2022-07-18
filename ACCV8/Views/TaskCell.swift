//
//  TaskCell.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 18/07/22.
//

import SwiftUI

struct TaskCell: View {
    let task: Tasks
    var selected: Bool
    let isSelected: (Bool) -> Void
    var body: some View {
        HStack {
            Image(systemName: selected ? "checkmark.square": "square")
                .onTapGesture {
                    isSelected(!selected)
                }
            
            VStack(alignment: .leading) {
                Text(task.taskTitle)
                Text(task.taskText)
                    .opacity(0.4)
                Text("\(task.startDate)")
                Text("\(task.dueDate)")
                Text(task.priority)
            }
        }.opacity(selected ? 0.4 : 1.0)
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(task: Tasks(), selected: true, isSelected: { _ in })
    }
}
