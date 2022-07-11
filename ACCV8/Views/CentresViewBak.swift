//
//  CentresView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 01/07/22.
//

import SwiftUI
import RealmSwift

struct CentresViewBak: View {
    @Environment(\.realm) var realm
    @ObservedResults(Centre.self) var centres
    var columns = [GridItem(.adaptive(minimum: 300), spacing: 20)]
    
    @State var show = false
    @State var showStatusBar = true
    @State var showCourse = false
    @State var selectedCourse: Course = courses[0]
    @State var contentHasScrolled = false
  
    
    @EnvironmentObject var model: Model
    @Namespace var namespace
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            ScrollView {
                scrollDetection
                Rectangle()
                    .frame(width: 100, height: 150)
                    .opacity(0)
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach (centres) { centre in
                VStack {
                        Image(uiImage: UIImage(data: centre.centreLogo!) ?? UIImage())
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
                        Text(centre.centreName)
                            .font(.title).bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.white)
                        
                        Text(centre.centreDesc)
                            .font(.footnote).bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.white.opacity(0.7))
                        
                        Text("A complete guide to designing for iOS 14 with videos, examples and design...")
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.white.opacity(0.7))
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
                        Image(uiImage: UIImage(data: centre.centreImage!) ?? UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(20)
                            .offset(y: -30)
                        
                    )
                    .background(
                        Image(uiImage: UIImage(data: centre.centreBackground!) ?? UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .disabled(true)
                    )
                    .mask(
                        RoundedRectangle(cornerRadius: 30)
                    )
//                    .overlay(
//                        Image(horizontalSizeClass == .compact ? "Waves 1" : "Waves 2")
//                            .frame(maxHeight: .infinity, alignment: .bottom)
//                            .offset(y: 0)
//                            .opacity(0)
//                    )
                    .frame(height: 300)
                }
            }
            }
            .coordinateSpace(name: "scroll")
            
            .padding(.horizontal, 20)
            .offset(y: -80)
            .background(Image("Blob 1").offset(x: -100, y: -400))
        }
        .overlay(NavigationBar(title: "Centres", contentHasScrolled: $contentHasScrolled))
        .task {
            do {
            try await setSubscription()
            } catch {
                
            }
        }
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
        
struct CentresViewBak_Previews: PreviewProvider {
    static var previews: some View {
        CentresViewBak()
            .environmentObject(Model())
           
    }
}
