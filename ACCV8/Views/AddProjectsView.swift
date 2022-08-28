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
    @State var owner_id = ""
    @State var owner_id2 = ""
    @State var projectBackgrnd = ""
    @State var projectPic = ""
    @State var projectLogoF = ""
    @State var latitude = ""
    @State var longitude = ""
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()

        VStack (alignment: .leading, spacing: 20){
            Text("Add Project")
                .font(.title.weight(.bold))
                .blendMode(.overlay)
            Text("(Authorisation required)")
                .font(.title3)
                .blendMode(.overlay)
            TextField("Project Name", text: $projectName)
                .customField(icon: "folder.circle")
            TextField("Project Text", text: $projectText)
                .customField(icon: "text.bubble")
            TextField("Project Background", text: $projectBackgrnd)
                .customField(icon: "folder.circle.fill")
            TextField("Project Owner", text: $owner_id)
                .customField(icon: "person.circle.fill")
            TextField("Project Logo", text: $projectLogoF)
                .customField(icon: "photo.fill")
            TextField("Latitude", text: $latitude)
                .customField(icon: "location.circle")
            TextField("Longitude", text: $longitude)
                .customField(icon: "location.circle.fill")
       
        Button {
                    
            let latD = Double(latitude) ?? 0.0
            let longD = Double(longitude) ?? 0.0
            let project = Projects()
            project.projectName = projectName
            project.projectText = projectText
            project.owner_id = owner_id
            project.owner_id2 = owner_id2
            project.projectBackgrnd = projectBackgrnd
            project.projectPic = projectPic
            project.projectLogoF = projectLogoF
            project.projectLocation.latitude = latD
            project.projectLocation.longitude = longD
            $projects.append(project)
            
            dismiss()
            
        } label: {
            AngularButton(title: "Save")
                
        }.buttonStyle(.plain)
        }
        .padding(.horizontal, 20)
        .background(
            Image("Blob 1")
                .offset(x: 70, y: -100)
                .accessibility(hidden: true)
        )
        }
    }

}

struct AddProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectsView()
    }
}
