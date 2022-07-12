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
    @Binding var centre: Centre
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
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
//                .matchedGeometryEffect(id: "logo\(centre.centreIndex)", in: namespace)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(centre.centreName)
                    .font(.title).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .matchedGeometryEffect(id: "title\(centre.centreIndex)", in: namespace)
                    .foregroundColor(.white)
                
                Text(centre.centreDesc)
                    .font(.footnote).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .matchedGeometryEffect(id: "subtitle\(centre.centreIndex)", in: namespace)
                    .foregroundColor(.white.opacity(0.7))
                
                Text(centre.centreText)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white.opacity(0.7))
//                    .matchedGeometryEffect(id: "description\(centre.centreIndex)", in: namespace)
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .cornerRadius(30)
                    .blur(radius: 30)
//                    .matchedGeometryEffect(id: "blur\(centre.centreIndex)", in: namespace)
            )
        }
        .background(
            Image(uiImage: UIImage(data: centre.centreImage!) ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(20)
                .opacity(0.4)
//                .matchedGeometryEffect(id: "image\(centre.centreIndex)", in: namespace)
                .offset(y: -30)
        )
        .background(
            Image(uiImage: UIImage(data: centre.centreBackground!) ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .disabled(true)
//                .matchedGeometryEffect(id: "background\(centre.centreIndex)", in: namespace)
        )
        .mask(
            RoundedRectangle(cornerRadius: 30)
//                .matchedGeometryEffect(id: "mask\(centre.centreIndex)", in: namespace)
        )
        .overlay(
            Image(horizontalSizeClass == .compact ? "Waves 1" : "Waves 2")
                .frame(maxHeight: .infinity, alignment: .bottom)
                .offset(y: 0)
                .opacity(0)
//                .matchedGeometryEffect(id: "waves\(centre.centreIndex)", in: namespace)
        )
        .frame(height: 300)
//        .onTapGesture {
//            withAnimation(.openCard) {
//                model.showDetail = true
//                model.selectedCentre = centre.centreIndex
//            }
//        }
    
    }
}


struct CentreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CentreDetailView(centre: .constant(Centre()))
    }
}
