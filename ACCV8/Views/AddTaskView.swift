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
    
    init(project: Projects, taskToEdit: Tasks? = nil) {
        self.project = project
        self.taskToEdit = taskToEdit
            
            if let taskToEdit = taskToEdit {
                _title = State(initialValue: taskToEdit.taskTitle)
                _desc = State(initialValue: taskToEdit.taskDescription)
                _text = State(initialValue: taskToEdit.taskText)
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
                TextField("Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                TextField("Description", text: $desc)
                    .textFieldStyle(.roundedBorder)
                
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
        $project.tasks.append(task)
    }
    
    private func update() {
        if let taskToEdit = taskToEdit {
            
            do {
                let realm = try Realm()
                guard let objectToUpdate = realm.object(ofType: Tasks.self, forPrimaryKey: taskToEdit.id) else { return }
                try realm.write {
                    objectToUpdate.taskTitle = title
                    objectToUpdate.taskDescription = desc
                    objectToUpdate.taskText = text
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
