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
    
    var body: some View {
        ZStack {
            ScrollView {
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
//                .matchedGeometryEffect(id: "image\(course.index)", in: namespace)
//                .offset(y: scrollY > 0 ? -scrollY : 0)
//                .accessibility(hidden: true)
        )
        .background(
            Image(uiImage: UIImage(data: centre.centreBackground!) ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
//                .matchedGeometryEffect(id: "background\(course.index)", in: namespace)
//                .offset(y: scrollY > 0 ? -scrollY : 0)
//                .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
//                .blur(radius: scrollY > 0 ? scrollY / 10 : 0)
//                .accessibility(hidden: true)
        )
        .mask(
            RoundedRectangle(cornerRadius: 30)
//                                appear[0] ? 0 : 30)
//                .matchedGeometryEffect(id: "mask\(course.index)", in: namespace)
//                .offset(y: scrollY > 0 ? -scrollY : 0)
        )
        .overlay(
            Image(horizontalSizeClass == .compact ? "Waves 1" : "Waves 2")
                .frame(maxHeight: .infinity, alignment: .bottom)
//                .offset(y: scrollY > 0 ? -scrollY : 0)
//                .scaleEffect(scrollY > 0 ? scrollY / 500 + 1 : 1)
//                .opacity(1)
//                .matchedGeometryEffect(id: "waves\(course.index)", in: namespace)
//                .accessibility(hidden: true)
        )
        .overlay(
            VStack(alignment: .leading, spacing: 16) {
                Text(centre.centreName)
                    .font(.title).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary)
//                    .matchedGeometryEffect(id: "title\(course.index)", in: namespace)
                
                Text(centre.centreDesc.uppercased())
                    .font(.footnote).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary.opacity(0.7))
//                    .matchedGeometryEffect(id: "subtitle\(course.index)", in: namespace)
                
                Text("A complete guide to designing for iOS 14 with videos, examples and design...")
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary.opacity(0.7))
//                    .matchedGeometryEffect(id: "description\(course.index)", in: namespace)
                
                Divider()
                    .foregroundColor(.secondary)
//                    .opacity(appear[1] ? 1 : 0)
                
                HStack {
                    LogoView(image: "Avatar 1")
                    Text("Taught by Meng To and Stephanie Diep")
                        .font(.footnote.weight(.medium))
                        .foregroundStyle(.secondary)
                }
//                .opacity(appear[1] ? 1 : 0)
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
//                    .matchedGeometryEffect(id: "blur\(course.index)", in: namespace)
//                    .opacity(appear[0] ? 0 : 1)
            )
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .backgroundStyle(cornerRadius: 30)
//                    .opacity(appear[0] ? 1 : 0)
            )
//            .offset(y: scrollY > 0 ? -scrollY * 1.8 : 0)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .offset(y: 100)
            .padding(20)
        )
//            Image(uiImage: UIImage(data: centre.centreLogo!) ?? UIImage())
//                .resizable()
//                .frame(width: 26, height: 26)
//                .cornerRadius(10)
//                .padding(8)
//                .background(.ultraThinMaterial)
//                .backgroundStyle(cornerRadius: 18, opacity: 0.4)
//                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
//                .padding(20)
////                .matchedGeometryEffect(id: "logo\(centre.centreIndex)", in: namespace)
//
//            Spacer()
//
//            VStack(alignment: .leading, spacing: 8) {
//                Text(centre.centreName)
//                    .font(.title).bold()
//                    .frame(maxWidth: .infinity, alignment: .leading)
////                    .matchedGeometryEffect(id: "title\(centre.centreIndex)", in: namespace)
//                    .foregroundColor(.white)
//
//                Text(centre.centreDesc)
//                    .font(.footnote).bold()
//                    .frame(maxWidth: .infinity, alignment: .leading)
////                    .matchedGeometryEffect(id: "subtitle\(centre.centreIndex)", in: namespace)
//                    .foregroundColor(.white.opacity(0.7))
//
//                Text(centre.centreText)
//                    .font(.footnote)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .foregroundColor(.white.opacity(0.7))
////                    .matchedGeometryEffect(id: "description\(centre.centreIndex)", in: namespace)
//            }
//            .padding(20)
//            .background(
//                Rectangle()
//                    .fill(.ultraThinMaterial)
//                    .frame(maxHeight: .infinity, alignment: .bottom)
//                    .cornerRadius(30)
//                    .blur(radius: 30)
////                    .matchedGeometryEffect(id: "blur\(centre.centreIndex)", in: namespace)
//            )
//
//        .background(
//            Image(uiImage: UIImage(data: centre.centreImage!) ?? UIImage())
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .padding(20)
//                .opacity(0.4)
////                .matchedGeometryEffect(id: "image\(centre.centreIndex)", in: namespace)
//                .offset(y: -30)
//        )
//        .background(
//            Image(uiImage: UIImage(data: centre.centreBackground!) ?? UIImage())
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .disabled(true)
////                .matchedGeometryEffect(id: "background\(centre.centreIndex)", in: namespace)
//        )
//        .mask(
//            RoundedRectangle(cornerRadius: 30)
////                .matchedGeometryEffect(id: "mask\(centre.centreIndex)", in: namespace)
//        )
//        .overlay(
//            Image(horizontalSizeClass == .compact ? "Waves 1" : "Waves 2")
//                .frame(maxHeight: .infinity, alignment: .bottom)
//                .offset(y: 0)
//                .opacity(0)
////                .matchedGeometryEffect(id: "waves\(centre.centreIndex)", in: namespace)
//        )
//        .frame(height: 300)
////        .onTapGesture {
////            withAnimation(.openCard) {
////                model.showDetail = true
////                model.selectedCentre = centre.centreIndex
////            }
////        }
//
        .frame(height: 500)
    }
            Button (action: {
                dismiss()
            }, label: {
                CloseButton()
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(40)
            .ignoresSafeArea()
    }
        .statusBar(hidden: true)
}
}


struct CentreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CentreDetailView(centre: .constant(Centre()))
    }
}
