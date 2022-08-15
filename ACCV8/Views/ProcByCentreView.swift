//
//  ProcByCentreView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 15/08/22.
//

import SwiftUI
import RealmSwift

struct ProcByCentreView: View {
    @State private var showSafari: Bool = false
    var body: some View {
      
        Text("View Procedures Yesterday")
                .padding()
                .onTapGesture {
                        showSafari.toggle()
                }
                .fullScreenCover(isPresented: $showSafari, content: {
                        SFSafariViewWrapper(url: URL(string: "https://charts.mongodb.com/charts-acc-ejzzg/public/dashboards/625265b6-5d61-4d08-86b4-48eef003d16f")!)
                })
    }
}

struct ProcByCentreView_Previews: PreviewProvider {
    static var previews: some View {
        ProcByCentreView()
    }
}
