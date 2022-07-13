//
//  CentreDetailView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 12/07/22.
//

import SwiftUI
import RealmSwift

struct CentreDetailView: View {
    @Environment(\.realm) var realm
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @Binding var centre: Centre
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var viewState: CGSize = .zero
    @State var appear = [false, false, false]
    var isAnimated = true
    var namespace: Namespace.ID
    
    @EnvironmentObject var model: Model
    
    var body: some View {
        ZStack {
            ScrollView {
                GeometryReader { proxy in
                    let scrollY = proxy.frame(in: .named("scroll")).minY
                VStack {
                    Spacer()
                    }
        .frame(maxWidth: .infinity)
        .frame(height: 500)
        .background(
            Image(uiImage: UIImage(data: centre.centreImage!) ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(20)
                .matchedGeometryEffect(id: "image\(centre.centreIndex)", in: namespace)
                .offset(y: scrollY > 0 ? -scrollY : 0)
                .accessibility(hidden: true)
        )
        .background(
            Image(uiImage: UIImage(data: centre.centreBackground!) ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "background\(centre.centreIndex)", in: namespace)
                .offset(y: scrollY > 0 ? -scrollY : 0)
                .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
                .blur(radius: scrollY > 0 ? scrollY / 10 : 0)
                .accessibility(hidden: true)
        )
        .mask(
            RoundedRectangle(cornerRadius: appear[0] ? 0 : 30)
                .matchedGeometryEffect(id: "mask\(centre.centreIndex)", in: namespace)
                .offset(y: scrollY > 0 ? -scrollY : 0)
        )
        .overlay(
            Image(horizontalSizeClass == .compact ? "Waves 1" : "Waves 2")
                .frame(maxHeight: .infinity, alignment: .bottom)
                .offset(y: scrollY > 0 ? -scrollY : 0)
                .scaleEffect(scrollY > 0 ? scrollY / 500 + 1 : 1)
                .opacity(1)
                .matchedGeometryEffect(id: "waves\(centre.centreIndex)", in: namespace)
                .accessibility(hidden: true)
        )
        .overlay(
            VStack(alignment: .leading, spacing: 16) {
                Text(centre.centreName)
                    .font(.title).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary)
                    .matchedGeometryEffect(id: "title\(centre.centreIndex)", in: namespace)
                
                Text(centre.centreDesc.uppercased())
                    .font(.footnote).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary.opacity(0.7))
                    .matchedGeometryEffect(id: "subtitle\(centre.centreIndex)", in: namespace)
                
                Text("Centre related stufff like facilities/equipment...")
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary.opacity(0.7))
                    .matchedGeometryEffect(id: "description\(centre.centreIndex)", in: namespace)
                
                Divider()
                    .foregroundColor(.secondary)
                    .opacity(appear[1] ? 1 : 0)
               
                HStack {
                    LogoView(image: "Avatar 1")
                    Text("Staff List ....")
                        .font(.footnote.weight(.medium))
                        .foregroundStyle(.secondary)
                }
              
                .opacity(appear[1] ? 1 : 0)
                .accessibilityElement(children: .combine)
            }
            
            .padding(20)
            .padding(.vertical, 10)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .cornerRadius(30)
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur\(centre.centreIndex)", in: namespace)
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
        .frame(height: 500)
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
            Button (action: {
                dismiss()
            }, label: {
                CloseButton()
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(20)
            .ignoresSafeArea()
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
                .ignoresSafeArea()
                .accessibility(hidden: true)
    }
        .zIndex(1)
        .onAppear { fadeIn() }
        .statusBar(hidden: true)
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
        withAnimation(.easeIn(duration: 0.1)) {
            appear[0] = false
            appear[1] = false
            appear[2] = false
        }
    }
}


struct CentreDetailView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        CentreDetailView(centre: .constant(Centre()), namespace: namespace)
    }
}
