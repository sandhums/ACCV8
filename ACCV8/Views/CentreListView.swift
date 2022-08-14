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
    @ObservedResults(Centre.self) var centres2
    @EnvironmentObject var model: Model
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var contentHasScrolled = false
    @State var showCentre = false
    @State var showCentre2 = false
    @State var showStatusBar = true
    @State var selectedCentre: Centre
   

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
                Text("List".uppercased())
                    .sectionTitleModifier()
                    .offset(y: -80)
                    .accessibilityAddTraits(.isHeader)
            LazyVGrid (columns: columns, spacing: 20) {
                let centres = realm.objects(Centre.self).sorted(byKeyPath: "centreIndex")
                ForEach(centres) { centre in
                    VStack {
                        Image(uiImage: UIImage(named: centre.centreLogoF)!)
//                        Image(uiImage: UIImage(data: centre.centreLogo!) ?? UIImage())
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
                            GradientText2(text: "\(centre.centreName)")
                                .font(Font.largeTitle.bold())
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.primary)
                            
                            Text(centre.centreDesc)
                                .font(Font.subheadline.bold())
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.primary)
                            
                            Text(centre.centreText)
                                .font(.footnote)
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
                        Image(uiImage: UIImage(named: centre.centrePic)!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(20)
                            .opacity(0.9)
                            .offset(x: 20, y: -50)
                    )
                    .background(
                        Image(uiImage: UIImage(named: centre.centreBackgrnd)!)
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
                            .opacity(0.7)
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
        }
        .fullScreenCover(isPresented: $showCentre2) {
            CentreDetailView(centre: $selectedCentre)
        }
        .overlay(NavigationBar(title: "Centres", contentHasScrolled: $contentHasScrolled))
        
    }
    var featured: some View {
        TabView {
            ForEach(centres2) { centre2 in
                GeometryReader { proxy in
                    FeaturedItem(centre: centre2)
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
                            Image(uiImage: UIImage(named: centre2.centrePic)!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .offset(x: 30, y: -90)
                                .opacity(0.7)
                                .frame(width: 320, height: 270)
                                .offset(x: proxy.frame(in: .global).minX / 2)
                                .blur(radius: abs(proxy.frame(in: .global).minX) / 50)
                        )
                        .padding(20)
                        .onTapGesture {
                            showCentre = true
                            selectedCentre = centre2
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
            CentreDetailView(centre: $selectedCentre)
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
}

struct CentreListView_Previews: PreviewProvider {
    static var previews: some View {
        Realm.bootstrap()
        
        return AppearancePreviews(CentreListView( selectedCentre: Centre.sample))
                 .previewLayout(.sizeThatFits)
                 .padding()
        
            .environmentObject(Model())
    }
}
