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
    @State private var title: String = ""
    @State private var desc: String = ""
    @State private var text = ""
    @State private var taskOwner = accApp.currentUser?.profile.email
    @State private var taskOwnerId = accApp.currentUser?.id
    @State private var startDate = Date()
    @State private var dueDate = Date()
    @State private var taskLogoF = ""
    @State private var priority = ""
    @State private var status = ""
    @State private var progressF = 0.0
    @State private var numberFormatter: NumberFormatter = {
        var nf = NumberFormatter()
        nf.numberStyle = .decimal
        return nf
    }()
    
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
                _priority = State(initialValue: taskToEdit.priority)
                _status = State(initialValue: taskToEdit.status)
                _progressF = State(initialValue: taskToEdit.progressF)
            }
        }
        
        private var isEditing: Bool {
            taskToEdit == nil ? false: true
        }
    var body: some View {
 
        VStack(alignment: .leading) {
                
                if !isEditing {
                    Text("Add Item")
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
                TextField("Priority", text: $priority)
                    .textFieldStyle(.roundedBorder)
                TextField("Status", text: $status)
                .textFieldStyle(.roundedBorder)
                TextField("Progress",  value: $progressF,
                          formatter: numberFormatter)
                .textFieldStyle(RoundedBorderTextFieldStyle())
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

                    .navigationTitle(isEditing ? "Update Item": "Add Item")
            }.padding()
        
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
        task.priority = priority
        task.status = status
        task.progressF = progressF
        $project.tasks.append(task)
    }
    
    private func update() {
      
        if let taskToEdit = taskToEdit {
            
            do {
                let realm = try Realm()
                guard let objectToUpdate = realm.object(ofType: Tasks.self, forPrimaryKey: taskToEdit._id) else { return }
                try realm.write {
                    objectToUpdate.taskTitle = title
                    objectToUpdate.taskDescription = desc
                    objectToUpdate.taskText = text
                    objectToUpdate.startDate = startDate
                    objectToUpdate.dueDate = dueDate
                    objectToUpdate.taskLogoF = taskLogoF
                    objectToUpdate.priority = priority
                    objectToUpdate.status = status
                    objectToUpdate.progressF = progressF
                }
            }
            catch {
                print(error)
            }
            
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(project: Projects())
    }
}
