//
//  CentreListView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 12/07/22.
//

import SwiftUI
import RealmSwift

struct CentreListView: View {
    @Environment(\.realm) var realm
    @ObservedResults(Centre.self) var centres
    @EnvironmentObject var model: Model
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var contentHasScrolled = false
    @State var showCentre = false
    @State var showCentre2 = false
    @State var showStatusBar = true
    @State var selectedCentre: Centre
    @Namespace var namespace

    var columns = [GridItem(.adaptive(minimum: 300), spacing: 20)]
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            ScrollView {
                scrollDetection
                Rectangle()
                    .frame(width: 100, height: 72)
                    .opacity(0)
              featured
            LazyVGrid (columns: columns, spacing: 20) {
                ForEach(centres) { centre in
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
                            .matchedGeometryEffect(id: "logo\(centre.centreIndex)", in: namespace)
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(centre.centreName)
                                .font(.title).bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .matchedGeometryEffect(id: "title\(centre.centreIndex)", in: namespace)
                                .foregroundColor(.white)
                            
                            Text(centre.centreDesc)
                                .font(.footnote).bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .matchedGeometryEffect(id: "subtitle\(centre.centreIndex)", in: namespace)
                                .foregroundColor(.white.opacity(0.7))
                            
                            Text(centre.centreText)
                                .font(.footnote)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.white.opacity(0.7))
                                .matchedGeometryEffect(id: "description\(centre.centreIndex)", in: namespace)
                        }
                        .padding(20)
                        .background(
                            Rectangle()
                                .fill(.ultraThinMaterial)
                                .frame(maxHeight: .infinity, alignment: .bottom)
                                .cornerRadius(30)
                                .blur(radius: 30)
                                .matchedGeometryEffect(id: "blur\(centre.centreIndex)", in: namespace)
                        )
                    }
                    .background(
                        Image(uiImage: UIImage(data: centre.centreImage!) ?? UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(20)
                            .opacity(0.4)
                           
                            .matchedGeometryEffect(id: "image\(centre.centreIndex)", in: namespace)
                            .offset(y: -30)
                    )
                    .background(
                        Image(uiImage: UIImage(data: centre.centreBackground!) ?? UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .disabled(true)
                            .matchedGeometryEffect(id: "background\(centre.centreIndex)", in: namespace)
                    )
                    .mask(
                        RoundedRectangle(cornerRadius: 30)
                            .matchedGeometryEffect(id: "mask\(centre.centreIndex)", in: namespace)
                    )
                    .overlay(
                        Image(horizontalSizeClass == .compact ? "Waves 1" : "Waves 2")
                            .frame(maxHeight: .infinity, alignment: .bottom)
                            .offset(y: 0)
                            .opacity(0)
                            .matchedGeometryEffect(id: "waves\(centre.centreIndex)", in: namespace)
                    )
                    .frame(height: 300)
                    
                
                .onTapGesture {
                    showCentre2 = true
                    selectedCentre = centre
                }
                }
            }
                
            .padding(.horizontal, 20)
            .offset(y: -80)
            
            }
            .coordinateSpace(name: "scroll")
//            .background(Image("Blob 1").offset(x: 150, y: -200))
        }
        .fullScreenCover(isPresented: $showCentre2) {
            CentreDetailView(centre: $selectedCentre, namespace: namespace)
        }
                .task {
                    do {
                    try await setSubscription()
                    } catch {
        
                    }
                }
        .overlay(NavigationBar(title: "Featured", contentHasScrolled: $contentHasScrolled))
        
    }
    var featured: some View {
        TabView {
            ForEach(centres) { centre in
                GeometryReader { proxy in
                    FeaturedItem(centre: centre)
                        .cornerRadius(30)
                        .modifier(OutlineModifier(cornerRadius: 30))
                        .rotation3DEffect(
                            .degrees(proxy.frame(in: .global).minX / -10),
                            axis: (x: 0, y: 1, z: 0), perspective: 1
                        )
                        .shadow(color: Color("Shadow").opacity(0.3),
                                radius: 30, x: 0, y: 30)
                        .blur(radius: abs(proxy.frame(in: .global).minX) / 40)
                        .overlay(
                            Image(uiImage: UIImage(data: centre.centreImage!) ?? UIImage())
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .offset(x: 12, y: -80)
                                .opacity(0.7)
                                .frame(width: 280, height: 230)
                                .offset(x: proxy.frame(in: .global).minX / 2)
                        )
                        .padding(20)
                        .onTapGesture {
                            showCentre = true
                            selectedCentre = centre
                        }
                        .accessibilityElement(children: .combine)
                        .accessibilityAddTraits(.isButton)
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 460)
        .background(
            Image("Blob 1")
                .offset(x: 250, y: -100)
                .accessibility(hidden: true)
        )
        .fullScreenCover(isPresented: $showCentre) {
            CentreDetailView(centre: $selectedCentre, namespace: namespace)
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

struct CentreListView_Previews: PreviewProvider {
    static var previews: some View {
        CentreListView(selectedCentre: Centre())
            .environmentObject(Model())
    }
}
