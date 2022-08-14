//
//  LocationView.swift
//  ACCv5
//
//  Created by Manjinder Sandhu on 22/05/22.
//

import SwiftUI
import MapKit
import RealmSwift

struct LocationView: View {
   
    @Environment(\.realm) var realm
    @ObservedResults(Centre.self) var centres
    @Environment(\.dismiss) var dismiss
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 24.681_858, longitude: 81.811_623),
        span: MKCoordinateSpan(latitudeDelta: 16, longitudeDelta: 16)
    )
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, interactionModes: .all, annotationItems: centres, annotationContent: { centre in
            MapAnnotation(coordinate: centre.centreLocation) {
                VStack {
                    Image(centre.centreLogoF)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 40)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.white, lineWidth: 25/10))
                        .shadow(radius: 10)
                    GradientText3(text: centre.centreName)
                        .font(.title3.bold())
                }
            }
            
         })
        Button (action: {
            dismiss()
        }, label: {
            CloseButton()
        })
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(20)
        .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}

    


struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
