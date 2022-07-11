//
//  CentresView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 11/07/22.
//

import SwiftUI
import RealmSwift

struct CentresView: View {
    @Environment(\.realm) var realm
    @ObservedResults(Centre.self) var centres
    var columns = [GridItem(.adaptive(minimum: 300), spacing: 20)]
    
    @State var show = false
    @State var showStatusBar = true
    @State var showCourse = false
    @State var selectedCentre = 1
    @State var contentHasScrolled = false
    
    @EnvironmentObject var model: Model
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            if model.showDetail {
                detail
            }
            
            ScrollView {
                scrollDetection
                
                Rectangle()
                    .frame(width: 100, height: 72)
                    .opacity(0)
                
//                featured
                
                Text("Centres".uppercased())
                    .sectionTitleModifier()
                    .offset(y: -80)
                    .accessibilityAddTraits(.isHeader)
                
                if model.showDetail {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(centres) { centre in
                            Rectangle()
                                .fill(.white)
                                .frame(height: 300)
                                .cornerRadius(30)
                                .shadow(color: Color("Shadow").opacity(0.2), radius: 20, x: 0, y: 10)
                                .opacity(0.3)
                        }
                    }
                    .padding(.horizontal, 20)
                    .offset(y: -80)
                } else {
                    LazyVGrid(columns: columns, spacing: 20) {
                        centre.frame(height: 300)
                    }
                    .padding(.horizontal, 20)
                    .offset(y: -80)
                }
            }
            .coordinateSpace(name: "scroll")
        }
        .onChange(of: model.showDetail) { value in
            withAnimation {
                model.showTab.toggle()
                model.showNav.toggle()
                showStatusBar.toggle()
            }
        }
        .overlay(NavigationBar(title: "Featured", contentHasScrolled: $contentHasScrolled))
        .statusBar(hidden: !showStatusBar)
    }
    
    var detail: some View {
        ForEach(centres) { centre in
            if centre.centreIndex == model.selectedCentre {
                CentreView(namespace: namespace, centre: .constant(centre))
            }
        }
    }
    
    var centre: some View {
        ForEach(centres) { centre in
            CentreItemView(namespace: namespace, centre: centre)
                .accessibilityElement(children: .combine)
                .accessibilityAddTraits(.isButton)
        }
    }
    
//    var featured: some View {
//        TabView {
//            ForEach(courses) { course in
//                GeometryReader { proxy in
//                    FeaturedItem(course: course)
//                        .cornerRadius(30)
//                        .modifier(OutlineModifier(cornerRadius: 30))
//                        .rotation3DEffect(
//                            .degrees(proxy.frame(in: .global).minX / -10),
//                            axis: (x: 0, y: 1, z: 0), perspective: 1
//                        )
//                        .shadow(color: Color("Shadow").opacity(0.3),
//                                radius: 30, x: 0, y: 30)
//                        .blur(radius: abs(proxy.frame(in: .global).minX) / 40)
//                        .overlay(
//                            Image(course.image)
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .offset(x: 32, y: -80)
//                                .frame(height: 230)
//                                .offset(x: proxy.frame(in: .global).minX / 2)
//                        )
//                        .padding(20)
//                        .onTapGesture {
//                            showCourse = true
//                            selectedCourse = course
//                        }
//                        .accessibilityElement(children: .combine)
//                        .accessibilityAddTraits(.isButton)
//                }
//            }
//        }
//        .tabViewStyle(.page(indexDisplayMode: .never))
//        .frame(height: 460)
//        .background(
//            Image("Blob 1")
//                .offset(x: 250, y: -100)
//                .accessibility(hidden: true)
//        )
//        .sheet(isPresented: $showCourse) {
//            CentreView(namespace: namespace, centre: $selectedCentre, isAnimated: false)
//        }
//    }
    
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
}

struct CentresView_Previews: PreviewProvider {
    static var previews: some View {
        CentresView(selectedCentre: Int())
            .environmentObject(Model())
    }
}
