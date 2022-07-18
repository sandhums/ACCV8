//
//  AddProjectView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 16/07/22.
//

import SwiftUI
import RealmSwift

struct AddProjectView: View {
    @Environment(\.realm) var realm
    @ObservedResults(Reps.self) var users
    
    @State var projectName = ""
    @State var projectText = ""
    @State var projectOwner = ""
    @State var projectOwnerId = ""
    @State var projectAdmin = ""
    @State var projectImage2 = ""
    @State var projectBackground = ""
    @State var projectLogo = ""
    @State var latitude = ""
    @State var longitude = ""
    
    @State var task1Title = ""
    @State var task1Desc = ""
    @State var task1Text = ""
    @State var task1Owner = ""
    @State var task1OwnerId = ""
    @State var startDate1 = Date()
    @State var dueDate1 = Date()
    @State var taskLogo1 = ""
    @State var priority1 = ""
    @State var status1 = ""
    @State var progress1 = ""
    
    var body: some View {
                VStack {
                TextField("Project Name", text: $projectName)
                TextField("Project Text", text: $projectText)
                TextField("Project Owner", text: $projectOwner)
                TextField("Project OwnerId", text: $projectOwnerId)
                TextField("Project Image2", text: $projectImage2)
                TextField("Project Background", text: $projectBackground)
                TextField("Project Logo", text: $projectLogo)
                TextField("Latitude", text: $latitude)
                TextField("Longitude", text: $longitude)
                }
               
                Divider()
                VStack {
                TextField("Task Name", text: $task1Title)
                TextField("Task Description", text: $task1Desc)
                TextField("Task Text", text: $task1Text)
                TextField("Task Owner", text: $task1Owner)
                TextField("Task Logo", text: $taskLogo1)
                TextField("Task priority", text: $priority1)
                TextField("Task status", text: $status1)
                TextField("Task progress", text: $progress1)
                }
               
                Divider()
                VStack {
                    DatePicker(selection: $startDate1, label: { Text("Start Date") })
                    DatePicker(selection: $dueDate1, label: { Text("Due Date") })
                }
                Button {
//                    addProject()

                } label: {
                    AngularButton(title: "Submit")
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
        let foundSubscription = subscriptions.first(named: "allProjects")
        try await subscriptions.update {
            if foundSubscription != nil {
                foundSubscription!.updateQuery(toType: Projects.self)
                print("updating query allProjects")
            } else {
                subscriptions.append(
                    QuerySubscription<Projects>(name: "allProjects"))
                print("appending query allProjects")
            }
        }
    }
}

struct AddProjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectView()
    }
}
