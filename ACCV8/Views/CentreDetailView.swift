//
//  CentreDetailView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 12/07/22.
//

import SwiftUI
import RealmSwift
import MessageUI
import MapKit

struct CentreDetailView: View {
    @Environment(\.realm) var realm
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @Binding var centre: Centre
    @ObservedResults(Centre.self) var centres
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var viewState: CGSize = .zero
    @State var appear = [false, false, false]
    var isAnimated = true
    @State var showToggle = true
    @EnvironmentObject var model: Model
    @State private var showingFullMap = false
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 24.681_858, longitude: 81.811_623),
        span: MKCoordinateSpan(latitudeDelta: 16, longitudeDelta: 16)
    )
    
    var body: some View {
        ZStack {
            ScrollView {
                centreDetail
                staffDetail
                    .opacity(appear[2] ? 1 : 0)
                }
            .coordinateSpace(name: "scroll")
            .background(Color("Background"))
            .mask(RoundedRectangle(cornerRadius: appear[0] ? 0 : 30))
            .mask(RoundedRectangle(cornerRadius: viewState.width / 3))
            .modifier(OutlineModifier(cornerRadius: viewState.width / 3))
            .shadow(color: Color("Shadow").opacity(0.5), radius: 30, x: 0, y: 10)
            .scaleEffect(-viewState.width/500 + 1)
            .background(Color("Shadow").opacity(viewState.width / 500))
            .background(.ultraThinMaterial)
            .gesture(isAnimated ? drag : nil)
            .ignoresSafeArea()
            Button {
                isAnimated ?
                withAnimation(.closeCard) {
                    showToggle = false
                }
                : dismiss()
            } label: {
                CloseButton()
            }
            .buttonStyle(.plain)
            .opacity(appear[0] ? 1 : 0)
            .offset(y: appear[0] ? 0 : 200)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(20)
            .ignoresSafeArea()
            Image(uiImage: UIImage(named: centre.centreLogoF)!)
//            Image(uiImage: UIImage(data: centre.centreLogo!) ?? UIImage())
                .resizable()
                .frame(width: 26, height: 26)
                .cornerRadius(10)
                .padding(8)
                .background(.ultraThinMaterial)
                .backgroundStyle(cornerRadius: 18, opacity: 0.4)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(20)
                .ignoresSafeArea()
                .accessibility(hidden: true)
                .opacity(appear[0] ? 1 : 0)
                .offset(y: appear[0] ? 0 : 200)
    }
        .zIndex(1)
        .onAppear { fadeIn() }
        .onChange(of: showToggle) { show in
           fadeOut()
        }
        .task {
            do {
            try await setSubscription()
            } catch {

            }
        }
        .statusBar(hidden: true)
}
    var centreDetail: some View {
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .named("scroll")).minY
        VStack {
            Spacer()
            }
.frame(maxWidth: .infinity)
.frame(height: scrollY > 0 ? 500 + scrollY : 500)
.background(
    Image(uiImage: UIImage(named: centre.centrePic)!)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(20)
        .opacity(0.9)
        .offset(y: -75)
        .offset(y: scrollY > 0 ? -scrollY : 0)
        .accessibility(hidden: true)
)
.background(
    Image(uiImage: UIImage(named: centre.centreBackgrnd)!)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .offset(y: scrollY > 0 ? -scrollY : 0)
        .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
        .blur(radius: scrollY > 0 ? scrollY / 10 : 0)
        .accessibility(hidden: true)
)
.mask(
    RoundedRectangle(cornerRadius: appear[0] ? 0 : 30)
        .offset(y: scrollY > 0 ? -scrollY : 0)
)
.overlay(
    Image(horizontalSizeClass == .compact ? "Waves 1" : "Waves 2")
        .frame(maxHeight: .infinity, alignment: .bottom)
        .offset(y: scrollY > 0 ? -scrollY : 0)
        .scaleEffect(scrollY > 0 ? scrollY / 500 + 1 : 1)
        .opacity(1)
        .accessibility(hidden: true)
)
.overlay(
    VStack(alignment: .leading, spacing: 16) {
        GradientText2(text: "\(centre.centreName)")
            .font(Font.largeTitle.bold())
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.primary)
        HStack {
        VStack {
        Text(centre.centreDesc.uppercased())
            .font(.footnote).bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.primary.opacity(0.7))
            .frame(height: 60)
        Text(centre.centreText)
            .font(.footnote)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.primary.opacity(0.7))
            .accessibilityElement(children: .combine)
        }
            VStack {
                Button(action: { showingFullMap.toggle() }) {     Map(coordinateRegion: $region, annotationItems: centres, annotationContent: { centre in
                    MapMarker(coordinate: centre.centreLocation) 
                    
                 })
                    
                .frame(width: 70, height: 70, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
                .buttonStyle(.plain)
            }
        }
    }
    
    .padding(20)
    .padding(.vertical, 10)
    .background(
        Rectangle()
            .fill(.ultraThinMaterial)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .cornerRadius(30)
            .blur(radius: 30)
            .opacity(appear[0] ? 0 : 1)
    )
    .background(
        Rectangle()
            .fill(.ultraThinMaterial)
            .backgroundStyle(cornerRadius: 30)
            .opacity(appear[0] ? 1 : 0)
    )
    .offset(y: scrollY > 0 ? -scrollY * 1.8 : 0)
    .frame(maxHeight: .infinity, alignment: .bottom)
    .offset(y: 100)
    .padding(20)
)
        }
        .sheet(isPresented: $showingFullMap){
            LocationView()
        }
        .frame(height: 500)
    }
    
    var staffDetail: some View {
        VStack(spacing: 16) {
        let chatsters = realm.objects(Chatster.self).sorted(byKeyPath: "userIndex")
        let centreStaffs = chatsters.where {
            $0.centreName == centre.centreName
        }
            ForEach (centreStaffs) { centreStaff in
                VStack {
                    HStack {
               UserAvatarViewNoCircle(photo: centreStaff.avatarImage)
                    Text(centreStaff.firstName)
                        .font(.footnote.weight(.bold))
                        .foregroundStyle(.secondary)
                    Text(centreStaff.lastName)
                        .font(.footnote.weight(.bold))
                        .foregroundStyle(.secondary)
                        Spacer()
                        Button(action: {
                            let phone = "tel://"
                            let phoneNumberformatted = phone + centreStaff.userMobile
                            guard let url = URL(string: phoneNumberformatted) else { return }
                            UIApplication.shared.open(url)
                           }) {
                               Image (systemName: "phone.circle.fill")
                                   .symbolRenderingMode(.multicolor)
                           }.buttonStyle(.plain)
                    }
                    HStack {
                        Text(centreStaff.designation)
                        .font(.footnote.weight(.medium))
                        .foregroundStyle(.secondary)
                        Spacer()
                        Button(action: {
                            let email = "mailto://"
                            let emailformatted = email + centreStaff.userName
                            guard let url = URL(string: emailformatted) else { return }
                            UIApplication.shared.open(url)
                              }) {
                             Image (systemName: "envelope.circle.fill")
                                .symbolRenderingMode(.multicolor)
                         }
                           .buttonStyle(.plain)
                    }
                }
                Divider()
                    .foregroundColor(.secondary)
        }
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .backgroundStyle(cornerRadius: 30)
        .padding(20)
        .padding(.vertical, 80)
//        .sheet(isPresented: $showSection) {
//            SectionView(section: $selectedSection)
//        }
    }
    func close() {
        withAnimation {
            viewState = .zero
        }
    }
    
    var drag: some Gesture {
        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .onChanged { value in
                guard value.translation.width > 0 else { return }
                
                if value.startLocation.x < 100 {
                    withAnimation {
                        viewState = value.translation
                    }
                }
                
                if viewState.width > 120 {
                    close()
                }
            }
            .onEnded { value in
                if viewState.width > 80 {
                    close()
                } else {
                    withAnimation(.openCard) {
                        viewState = .zero
                    }
                }
            }
    }
    
    func fadeIn() {
        withAnimation(.easeOut.delay(0.3)) {
            appear[0] = true
        }
        withAnimation(.easeOut.delay(0.4)) {
            appear[1] = true
        }
        withAnimation(.easeOut.delay(0.5)) {
            appear[2] = true
        }
    }
    
    func fadeOut() {
        withAnimation(.easeIn(duration: 0.4)) {
            appear[0] = false
            appear[1] = false
            appear[2] = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4)  {
                dismiss()
            }
           
        }
    }
    private func setSubscription() async throws {
        let subscriptions = realm.subscriptions
        let foundSubscription = subscriptions.first(named: "allChatsters")
        try await subscriptions.update {
            if foundSubscription != nil {
                foundSubscription!.updateQuery(toType: Chatster.self)
                print("updating query allChatsters")
            } else {
                subscriptions.append(
                    QuerySubscription<Chatster>(name: "allChatsters"))
                print("appending query allChatsters")
            }
        }
    }
}


struct CentreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Realm.bootstrap()
        
        return AppearancePreviews(CentreDetailView(centre: .constant(Centre.sample)))
                 .previewLayout(.sizeThatFits)
                 .padding()
                 .environment(\.realmConfiguration, (accApp.currentUser?.flexibleSyncConfiguration())!)
    }
}
