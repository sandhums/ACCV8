//
//  ProjectView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 19/08/22.
//

import SwiftUI
import RealmSwift

struct ProjectView: View {
    @Environment(\.realm) var realm
    @EnvironmentObject var model: Model
    @ObservedResults(Projects.self) var projects
//    @State var showTasks = false
//    @State var selectedProject: Projects
    @State var contentHasScrolled = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var columns = [GridItem(.adaptive(minimum: 250), spacing: 20)]
    var body: some View {
        ZStack {
        Color("Background").ignoresSafeArea()
      
        projectList
        .background(
            Image("Blob 1")
                .offset(x: 250, y: -100)
                .accessibility(hidden: true)
        )
        }
        .task {
            do {
            try await setSubscription()
            } catch {
                
            }
    }
        
//
    }
    var projectList: some View {
        ScrollView {
            scrollDetection
            Rectangle()
                .frame(width: 100, height: 150)
                .opacity(0)
        LazyVGrid (columns: columns, spacing: 20) {
            ForEach (projects) { project in
                VStack {
                    Image(uiImage: UIImage(named: project.projectLogoF)!)
//                        Image(uiImage: UIImage(data: centre.centreLogo!) ?? UIImage())
                        .resizable()
                        .frame(width: 30, height: 30)
                        .cornerRadius(10)
                        .padding(4)
                        .background(.ultraThinMaterial)
                        .backgroundStyle(cornerRadius: 18, opacity: 0.4)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding(20)
                    
                    Spacer()
                    VStack(alignment: .leading, spacing: 8) {
                        GradientText2(text: "\(project.projectName)")
                            .font(Font.largeTitle.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.primary)
                        
                        Text(project.projectText)
                            .font(Font.subheadline.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.primary)
                    }
                    .padding(20)
                    .background(
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                            .cornerRadius(30)
                            .blur(radius: 30)
                    )
                }
                .background(
                    Image(uiImage: UIImage(named: project.projectPic)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(20)
                        .opacity(0.9)
                        .offset(x: 20, y: -50)
                )
                .background(
                    Image(uiImage: UIImage(named: project.projectBackgrnd)!)
//                        Image(uiImage: UIImage(data: centre.centreBackground!) ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .disabled(true)
                )
                .mask(
                    RoundedRectangle(cornerRadius: 30)
                )
                .overlay(
                    Image(horizontalSizeClass == .compact ? "Waves 1" : "Waves 2")
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .offset(y: 0)
                        .opacity(0.4)
                )
                .frame(height: 300)
            }
        }
        .padding(.horizontal, 20)
        .offset(y: -80)
        }
        .coordinateSpace(name: "scroll")
        .overlay(NavigationBar(title: "Projects", contentHasScrolled: $contentHasScrolled))
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

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView()
    }
}
