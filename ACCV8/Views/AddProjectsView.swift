//
//  AddProjectsView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 18/07/22.
//

import SwiftUI
import RealmSwift

struct AddProjectsView: View {
    @EnvironmentObject var model: Model
    @Environment(\.realm) var realm
    @ObservedResults(Projects.self) var projects
    @Environment(\.dismiss) private var dismiss
    
    @State var projectName = ""
    @State var projectText = ""
    @State var projectOwner = ""
    @State var projectOwnerId = ""
    @State var projectAdmin = ""
    @State var projectBackgrnd = ""
    @State var projectLogoF = ""
    @State var latitude = ""
    @State var longitude = ""
    var body: some View {
        VStack {
        TextField("Project Name", text: $projectName)
        TextField("Project Text", text: $projectText)
        TextField("Project Owner", text: $projectOwner)
        TextField("Project OwnerId", text: $projectOwnerId)
        TextField("Project Background", text: $projectBackgrnd)
        TextField("Project Logo", text: $projectLogoF)
        TextField("Latitude", text: $latitude)
        TextField("Longitude", text: $longitude)
        }
        Button {
                     
            let latD = Double(latitude) ?? 0.0
            let longD = Double(longitude) ?? 0.0
            let project = Projects()
            project.projectName = projectName
            project.projectText = projectText
            project.projectOwner = projectOwner
            project.projectOwnerId = projectOwnerId
            project.projectBackgrnd = projectBackgrnd
            project.projectLogoF = projectLogoF
            project.projectLocation.latitude = latD
            project.projectLocation.longitude = longD
            $projects.append(project)
            
            dismiss()
            
        } label: {
            Text("Save")
                .frame(maxWidth: .infinity)
        }.buttonStyle(.bordered)
 
    }

}

struct AddProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectsView()
    }
}
