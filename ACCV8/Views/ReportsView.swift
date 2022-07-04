//
//  ReportsView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 01/07/22.
//

import SwiftUI

struct ReportsView: View {
    @State var contentHasScrolled = false
    @State private var showTab: Bool = true
    
    var body: some View {
        ZStack {
            Text ("Reports")
        }

    }
}
struct ReportsView_Previews: PreviewProvider {
    static var previews: some View {
        ReportsView()
            .environmentObject(Model())
    }
}
