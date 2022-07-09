//
//  Handbook.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 01/07/22.
//

import SwiftUI

struct Handbook: Identifiable {
    let id = UUID()
    var title: String
    var subtitle: String
    var text: String
    var logo: String
    var image: String
    var color1: Color
    var color2: Color
}

var handbooks = [
    Handbook(title: "Procedure Report", subtitle: "Daily Procedure count", text: "Unlisted procedure in the blank space !", logo: "Logo 1", image: "Illustration 1", color1: .teal, color2: .blue),
    Handbook(title: "Revenue Report", subtitle: "Daily IPD/OPD Revenue", text: "Add daily collection amount also !", logo: "Logo 1", image: "Illustration 2", color1: .purple, color2: .pink)
]
