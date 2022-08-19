//
//  TaskView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 19/08/22.
//

import SwiftUI
import RealmSwift

struct TaskView: View {
    @Environment(\.realm) var realm
    @Binding var project: Projects
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(project: .constant(Projects.sample))
    }
}
