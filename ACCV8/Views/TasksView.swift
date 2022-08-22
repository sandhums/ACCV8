//
//  TasksView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 18/07/22.
//

import SwiftUI
import RealmSwift

enum Sections: String, CaseIterable {
    case inprogress = "In Progress"
    case completed = "Completed"
}
struct TasksView: View {
    @EnvironmentObject var model: Model
    @Environment(\.realm) var realm
    @ObservedRealmObject var project: Projects
//    @Binding var project: Projects
    @ObservedResults (Tasks.self) var tasks2
    @State private var isPresented: Bool = false
    var tasks: [Tasks] {
        return Array(project.tasks)
    }
    var pendingTasks: [Tasks] {
        project.tasks.filter { $0.isCompleted == false }
      }
      
      var completedTasks: [Tasks] {
          project.tasks.filter { $0.isCompleted == true }
      }
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
        VStack {
            if tasks.isEmpty {
                Text("No tasks found.")
            }
            
            List {
                ForEach(Sections.allCases, id: \.self) { section in
                    Section {
                        let filteredTasks = section == .inprogress ? pendingTasks: completedTasks
                        
                        if filteredTasks.isEmpty {
                            Text("No tasks.")
                        }
                        ForEach(filteredTasks, id: \.self) { task in
                            NavigationLink {
                                AddTaskView(project: project, taskToEdit: task)
                            } label: {
                        TaskRow(task: task)
                            }
                    
                }
                .onDelete { indexSet in

                    indexSet.forEach { index in
                        let task = filteredTasks[index]
                        if let indexToDelete = project.tasks.firstIndex(where: { $0._id == task._id }) {
                                                           // delete the item
                                                           $project.tasks.remove(at: indexToDelete)
                            guard let taskToDelete = realm.object(ofType: Tasks.self, forPrimaryKey: task._id) else {
                                                       return
                                                   }
                            $tasks2.remove(taskToDelete)
                    }
                }
                }
                } header: {
                    Text(section.rawValue)
                }
                }
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
                .buttonStyle(.plain)
            }
        }
        }
        .sheet(isPresented: $isPresented) {
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
