//
//  TasksView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 18/07/22.
//

import SwiftUI
import RealmSwift

struct TasksView: View {
    @EnvironmentObject var model: Model
    @Environment(\.realm) var realm
    @ObservedRealmObject var project: Projects
    @State private var isPresented: Bool = false
    @State private var selectedTaskIds: [ObjectId] = []
    var tasks: [Tasks] {
        return Array(project.tasks)
    }
    var body: some View {
        VStack {
            if tasks.isEmpty {
                Text("No tasks found.")
            }
            
            List {
                ForEach(tasks) { task in
                    
                    NavigationLink {
                        AddTaskView(project: project, taskToEdit: task)
                    } label: {
                        TaskCell(task: task, selected: selectedTaskIds.contains(task._id)) { selected in
                            if selected {
                                selectedTaskIds.append(task._id)
                                if let indexToDelete = project.tasks.firstIndex(where: { $0.id == task.id }) {
                                    // delete the item
                                    $project.tasks.remove(at: indexToDelete)
                                }
                            }
                        }
                    }
                    
                    
                    
                }.onDelete(perform: $project.tasks.remove)
            }
            
            .navigationTitle(project.projectName)
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // action
                    isPresented = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }.sheet(isPresented: $isPresented) {
            AddTaskView(project: project)
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView(project: Projects())
    }
}
