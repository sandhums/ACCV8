//
//  CentresView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 01/07/22.
//

import SwiftUI
import RealmSwift

struct CentresView: View {
    var columns = [GridItem(.adaptive(minimum: 300), spacing: 20)]
    
    @State var show = false
    @State var showStatusBar = true
    @State var showCourse = false
    @State var selectedCourse: Course = courses[0]
    @State var contentHasScrolled = false
    
    @State private var showTab: Bool = true
    
    
    var body: some View {
        ZStack {
            Color("secondaryBackground").ignoresSafeArea()
        }
    }
}
struct CentresView_Previews: PreviewProvider {
    static var previews: some View {
        CentresView()
            
    }
}
