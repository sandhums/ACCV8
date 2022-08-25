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
    @ObservedResults(Reps.self) var users
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var desc = ""
    @State private var text = ""
    @State private var owner_id = ""
    @State private var owner_id2 = ""
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
                _dueDate = State(initialValue: taskToEdit.dueDate)
                _taskLogoF = State(initialValue: taskToEdit.taskLogoF)
                _taskPriority = State(initialValue: taskToEdit.taskPriority)
                _progressF = State(initialValue: String(taskToEdit.progressF))
            }
        }
        
        private var isEditing: Bool {
            taskToEdit == nil ? false: true
        }
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
        VStack(alignment: .leading) {
                
                if !isEditing {
                  Text("Add Task")
                        .font(.largeTitle)
                        .blendMode(.overlay)
                }
            Text("(Authorisation required)")
                .font(.title3)
                .blendMode(.overlay)
                Spacer().frame(height: 60)
            VStack {
              
                TextField("Title", text: $title)
                    .customField(icon: "textformat")
                TextField("Description", text: $desc)
                    .customField(icon: "text.alignleft")
                TextField("Text", text: $text)
                    .customField(icon: "list.bullet.circle")
                DatePicker(selection: $dueDate, label: { Text("Due Date") })
            }
            VStack {
                TextField("Logo", text: $taskLogoF)
                    .customField(icon: "photo.circle")
                Picker("Priority", selection: $taskPriority) {
                    ForEach(TaskPriority.allCases, id: \.self) { priority in
                        Text(priority.rawValue)
                    }
                }.pickerStyle(.segmented)
                TextField("Progress",  text: $progressF)
                    .customField(icon: "number.square")
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
                    AngularButton(title: isEditing ? "Update": "Save")
                        .frame(maxWidth: .infinity, maxHeight: 40)
                }.buttonStyle(.plain)
                    .padding(.top, 20)
                Spacer()

                    .navigationTitle(isEditing ? "Update Task": "Add Task")
            }
        .padding()
        .background(
            Image("Blob 1")
                .offset(x: 70, y: -100)
                .accessibility(hidden: true)
        )
        }
    }
    
    private func save() {
       
        let task = Tasks()
        task.taskTitle = title
        task.taskDescription = desc
        task.taskText = text
        task.dueDate = dueDate
        task.taskLogoF = taskLogoF
        task.taskPriority = taskPriority
        task.progressF = Double(progressF) ?? 0.0
        $project.tasks.append(task)
    }
    
    private func update() {
//        let user = users.first
        if let taskToEdit = taskToEdit {
            do {
                var config = accApp.currentUser?.flexibleSyncConfiguration()
                let realm = try Realm(configuration: config!)
                try realm.write {
                    realm.create(Tasks.self,
                                 value: ["_id": taskToEdit._id, "taskTitle": title, "taskDescription": desc, "taskText": text, "dueDate": dueDate, "taskLogoF": taskLogoF, "taskPriority": taskPriority, "progressF": Double(progressF) ?? 0.0],
                                    update: .modified)
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
