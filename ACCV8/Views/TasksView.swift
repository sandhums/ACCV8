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
//    var tasks: [Tasks] {
//        return Array(project.tasks)
//    }
    var body: some View {
        VStack {
//            if tasks.isEmpty {
//                Text("No tasks found.")
//            }
            
            List {
                ForEach(project.tasks) { task in
                    
                    NavigationLink {
                        AddTaskView(project: project, taskToEdit: task)
                    } label: {
                        TaskRow(task: task)
//                                if let indexToDelete = project.tasks.firstIndex(where: { $0._id == task._id }) {
//                                    // delete the item
//                                    $project.tasks.remove(at: indexToDelete)
//                                }
                      
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
        .task {
            do {
            try await setSubscription()
            } catch {
                
            }
        }
    }
    private func setSubscription() async throws {
        let subscriptions = realm.subscriptions
        let foundSubscription = subscriptions.first(named: "allTasks")
        try await subscriptions.update {
            if foundSubscription != nil {
                foundSubscription!.updateQuery(toType: Tasks.self)
                print("updating query allTasks")
            } else {
                subscriptions.append(
                    QuerySubscription<Tasks>(name: "allTasks"))
                print("appending query allTasks")
            }
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView(project: Projects())
    }
}
