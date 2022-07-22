//
//  AddTaskView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 18/07/22.
//

import SwiftUI
import RealmSwift

struct AddTaskView: View {
    @EnvironmentObject var model: Model
    @Environment(\.realm) var realm
    @ObservedRealmObject var project: Projects
    var taskToEdit: Tasks?
       
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var desc = ""
    @State private var text = ""
    @State private var taskOwner = accApp.currentUser?.profile.email
    @State private var taskOwnerId = accApp.currentUser?.id
    @State private var startDate = Date()
    @State private var dueDate = Date()
    @State private var taskLogoF = ""
    @State private var taskPriority: TaskPriority = .medium
    @State private var status = "notStarted"
    @State private var progressF = ""
//    @State private var numberFormatter: NumberFormatter = {
//        var nf = NumberFormatter()
//        nf.numberStyle = .decimal
//        return nf
//    }()
    
    init(project: Projects, taskToEdit: Tasks? = nil) {
        self.project = project
        self.taskToEdit = taskToEdit
        
            if let taskToEdit = taskToEdit {
                _title = State(initialValue: taskToEdit.taskTitle)
                _desc = State(initialValue: taskToEdit.taskDescription)
                _text = State(initialValue: taskToEdit.taskText)
                _startDate = State(initialValue: taskToEdit.startDate)
                _dueDate = State(initialValue: taskToEdit.dueDate)
                _taskLogoF = State(initialValue: taskToEdit.taskLogoF)
                _taskPriority = State(initialValue: taskToEdit.taskPriority)
                _status = State(initialValue: taskToEdit.status)
                _progressF = State(initialValue: String(taskToEdit.progressF))
            }
        }
        
        private var isEditing: Bool {
            taskToEdit == nil ? false: true
        }
    var body: some View {
 
        VStack(alignment: .leading) {
                
                if !isEditing {
                    Text("Add Task")
                        .font(.largeTitle)
                }
                
                Spacer().frame(height: 60)
            VStack {
                TextField("Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                TextField("Description", text: $desc)
                    .textFieldStyle(.roundedBorder)
                TextField("Text", text: $text)
                .textFieldStyle(.roundedBorder)
                DatePicker(selection: $startDate, label: { Text("Start Date") })
                DatePicker(selection: $dueDate, label: { Text("Due Date") })
            }
            VStack {
                TextField("Logo", text: $taskLogoF)
                    .textFieldStyle(.roundedBorder)
                Picker("Priority", selection: $taskPriority) {
                    ForEach(TaskPriority.allCases, id: \.self) { priority in
                        Text(priority.rawValue)
                    }
                }.pickerStyle(.segmented)
                TextField("Status", text: $status)
                .textFieldStyle(.roundedBorder)
                TextField("Progress",  text: $progressF)
                .textFieldStyle(.roundedBorder)
            }
                Button {
                    // save or update the item
                    
                    if let _ = taskToEdit {
                        // update
                        update()
                    } else {
                        // save
                        save()
                    }
                    
                    dismiss()
                    
                } label: {
                    Text(isEditing ? "Update": "Save")
                        .frame(maxWidth: .infinity, maxHeight: 40)
                }.buttonStyle(.bordered)
                    .padding(.top, 20)
                Spacer()

                    .navigationTitle(isEditing ? "Update Task": "Add Task")
            }
        .padding()
//        .task {
//            do {
//            try await setSubscription()
//            } catch {
//
//            }
//        }
    }
    
    private func save() {
       
        let task = Tasks()
        task.taskTitle = title
        task.taskDescription = desc
        task.taskText = text
        task.taskOwner = taskOwner!
        task.taskOwnerId = taskOwnerId!
        task.startDate = startDate
        task.dueDate = dueDate
        task.taskLogoF = taskLogoF
        task.taskPriority = taskPriority
        task.status = status
        task.progressF = Double(progressF) ?? 0.0
        $project.tasks.append(task)
    }
    
    private func update() {
      
        if let taskToEdit = taskToEdit {
            do {
                let realm = try Realm()
                print("so far so good")
//                let idOfContactToUpdate = taskToEdit._id
//                print("Contact \(idOfContactToUpdate) found")
//                let objectToUpdate = realm.object(ofType: Tasks.self, forPrimaryKey: idOfContactToUpdate)
                guard let objectToUpdate = realm.object(ofType: Tasks.self, forPrimaryKey: taskToEdit._id) else {
                    print("Contact \(taskToEdit._id) not found")
                    return }
                try realm.write {
//                    realm.create(Tasks.self,
//                                 value: ["_id": taskToEdit._id, "taskTitle": title, "taskDescription": desc, "taskText": text, "startDate": startDate, "dueDate": dueDate, "taskLogoF": taskLogoF, "priority": priority, "status": status, "progressF": Double(progressF) ?? 0.0],
//                                    update: .modified)
                    objectToUpdate.taskTitle = title
                    objectToUpdate.taskDescription = desc
                    objectToUpdate.taskText = text
                    objectToUpdate.taskOwner = taskOwner!
                    objectToUpdate.taskOwnerId = taskOwnerId!
                    objectToUpdate.startDate = startDate
                    objectToUpdate.dueDate = dueDate
                    objectToUpdate.taskLogoF = taskLogoF
                    objectToUpdate.taskPriority = taskPriority
                    objectToUpdate.status = status
                    objectToUpdate.progressF = Double(progressF) ?? 0.0
                    print("updated tasks")
                }
            }
            catch {
                print(error)
            }
            
        }
    }
    private func setSubscription() async throws {
        let subscriptions = realm.subscriptions
        let foundSubscription = subscriptions.first(named: "taskToEdit")
        try await subscriptions.update {
            if foundSubscription != nil {
                foundSubscription!.updateQuery(toType: Tasks.self, where: {
                    $0._id == taskToEdit!._id
                })
                print("updating query taskToEdit")
            } else {
                subscriptions.append(
                    QuerySubscription<Tasks>(name: "taskToEdit"){
                    $0._id == taskToEdit!._id
                })
                print("appending query taskToEdit")
            }
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(project: Projects())
    }
}
