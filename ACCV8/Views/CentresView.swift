//
//  CentresView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 01/07/22.
//

import SwiftUI
import RealmSwift

struct CentresView: View {
    var columns = [GridItem(.adaptive(minimum: 300), spacing: 20)]
    
    @State var show = false
    @State var showStatusBar = true
    @State var showCourse = false
    @State var selectedCourse: Course = courses[0]
    @State var contentHasScrolled = false
    @ObservedResults(Centre.self) var centres
    @Environment(\.realm) var realm
    @State private var showTab: Bool = true
    
    
    var body: some View {
        ZStack {
            Color("settingsBackground").ignoresSafeArea()
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(centres) { centre in
                            ZStack {
                            Rectangle()
                                .fill(.ultraThinMaterial)
                                .frame(height: 300)
                                .cornerRadius(30)
                                .shadow(color: .white.opacity(0.8), radius: 3, x: 0, y: 10)
                                .opacity(0.7)
                                .padding()
                                VStack(alignment: .leading, spacing: 8) {
//                                    Spacer()
                                    Image("Illustration 1")
                                        .resizable()
                                        .frame(width: 26, height: 26)
                                        .cornerRadius(10)
                                        .padding(8)
                                        .background(.ultraThinMaterial)
                                        .cornerRadius(18)
                                        .modifier(OutlineOverlay(cornerRadius: 18))
                                    Text(centre.centreName)
                                        .font(.title).bold()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(centre.centreDesc.uppercased())
                                        .font(.footnote.weight(.semibold))
                                        .foregroundStyle(.secondary)
//                                    Text(course.text)
//                                        .font(.footnote)
//                                        .foregroundStyle(.secondary)
//                                        .lineLimit(sizeCategory > .large ? 1 : 2)
//                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Spacer()
                                }
                                .padding(.horizontal, 30)
                                .padding(.vertical, 40)
//                                .frame(maxWidth: .infinity)
//                                .frame(height: 350)
//                                .background(.ultraThinMaterial)
//                                .backgroundColor(opacity: 0.5)
                            }
                                
                        }
                    }
                }
            }
        }
        .onAppear {
            let navBarLook = UINavigationBarAppearance()
            navBarLook.backgroundColor = UIColor(Color("settingsBackground"))
            UINavigationBar.appearance().standardAppearance = navBarLook
            UINavigationBar.appearance().scrollEdgeAppearance = navBarLook
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
        let foundSubscription = subscriptions.first(named: "allCentres")
        try await subscriptions.update {
            if foundSubscription != nil {
                foundSubscription!.updateQuery(toType: Centre.self)
                print("updating query allCentres")
            } else {
                subscriptions.append(
                    QuerySubscription<Centre>(name: "allCentres"))
                print("appending query allCentres")
            }
        }
    }
}
struct CentresView_Previews: PreviewProvider {
    static var previews: some View {
        CentresView()
           
    }
}
