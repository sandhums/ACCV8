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
//    var selected: Bool
//    let isSelected: (Bool) -> Void
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
      
            Image(task.taskLogoF)
                .resizable()
                .frame(width: 36, height: 36)
                .mask(Circle())
                .padding(12)
                .background(Color(UIColor.systemBackground).opacity(0.3))
                .mask(Circle())
                .overlay(CircularView(value: task.progressF))
            VStack(alignment: .leading, spacing: 8) {
                Text(task.taskTitle)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.secondary)
                Text(task.taskDescription)
                    .fontWeight(.semibold)
                Text(task.taskText)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.secondary)
                ProgressView(value: task.progressF)
                    .accentColor(.white)
                    .frame(maxWidth: 132)
            }
//            .onTapGesture {
//                isSelected(!selected)
//            }
            Spacer()
        }
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(task: Tasks())
    }
}
