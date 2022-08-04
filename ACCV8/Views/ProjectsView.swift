//
//  ProjectsView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 01/07/22.
//

import SwiftUI
import RealmSwift

struct ProjectsView: View {
    @Environment(\.realm) var realm
    @EnvironmentObject var model: Model
    @ObservedResults(Projects.self) var projects
     @State private var isPresented: Bool = false
    @State var contentHasScrolled = false
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                }
            .background(Color("Background"))
            .frame(maxWidth: .infinity)
    //        .frame(height: 500)
            .background(
                Image("background-1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
    //                .opacity(0.8)
                    .ignoresSafeArea()
                    .accessibility(hidden: true))
          
        NavigationView {
          
                  VStack {
                      
                      if projects.isEmpty {
                          Text("No Projects!")
                      }
                      
                      List {
                          ForEach(projects, id: \._id) { project in
                              NavigationLink {
                                 TasksView(project: project)
                              } label: {
                                  VStack {
                                      Image(uiImage: UIImage(named: project.projectLogoF)!)
                                          .resizable()
                                          .frame(width: 26, height: 26)
                                          .cornerRadius(10)
                                          .padding(8)
                                          .background(.ultraThinMaterial)
                                          .backgroundStyle(cornerRadius: 18, opacity: 0.4)
                                          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                          .padding(20)
                                      Spacer()
                                      VStack(alignment: .leading, spacing: 8) {
                                          Text(project.projectName)
                                              .font(.title).bold()
                                              .frame(maxWidth: .infinity, alignment: .leading)
                                              .foregroundColor(.white)
                                          
                                          Text(project.projectText)
                                              .font(.footnote).bold()
                                              .frame(maxWidth: .infinity, alignment: .leading)
                                              .foregroundColor(.white.opacity(0.7))
                                      }
                                      .padding(20)
                                      .background(
                                        Rectangle()
                                            .fill(.ultraThinMaterial)
                                            .frame(maxHeight: .infinity, alignment: .bottom)
                                            .cornerRadius(30)
//                                            .blur(radius: 30)
                                      )
                                  }
//                                  .background(
////                                    Image(uiImage: UIImage(data: project.projectImage!) ?? UIImage())
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .padding(20)
//                                        .opacity(0.4)
//                                        .offset(y: -30)
//                                  )
                                  .background(
                                    Image(uiImage: UIImage(named: project.projectBackgrnd)!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .disabled(true)
                                  )
                                  .mask(
                                    RoundedRectangle(cornerRadius: 30))
                                  
                                  .frame(height: 300)
                              }
                             
                          }.onDelete {  indexSet in
                              
                              indexSet.forEach { index in
                                  let project = projects[index]
                              guard let projectToDelete = realm.object(ofType: Projects.self, forPrimaryKey: project._id) else {
                                                            return
                                                        }
                                  for task in projectToDelete.tasks {
                                                              try? realm.write {
                                                                  realm.delete(task)
                                                              }
                                                          }
                                  $projects.remove(projectToDelete)
                          }

                      }
                      
                          .navigationTitle("Projects")
                         
                  }
                      .toolbar {
                          ToolbarItem(placement: .navigationBarTrailing) {
                              Button {
                                  // action
                                  isPresented = true
                              } label: {
                                  Image(systemName: "plus")
                              }
                          }
                      }
                  .sheet(isPresented: $isPresented, content: {
                     AddProjectsView()
                  })
    
              }

            .task {
                do {
                try await setSubscription()
                } catch {
                    
                }
        }
            
        }

        .coordinateSpace(name: "scroll")
        }
//        .overlay(NavigationBar(title: "Projects", contentHasScrolled: $contentHasScrolled))
    }
    var scrollDetection: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scroll")).minY
            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
        }
        .onPreferenceChange(ScrollPreferenceKey.self) { value in
            withAnimation(.easeInOut) {
                if value < 0 {
                    contentHasScrolled = true
                } else {
                    contentHasScrolled = false
                }
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

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
