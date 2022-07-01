//
//  Tab.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 30/06/22.
//

import SwiftUI

struct TabItem: Identifiable {
    let id = UUID()
    var name: String
    var icon: String
    var color: Color
    var selection: Tab
}

var tabItems = [
    TabItem(name: "Centres", icon: "heart.circle", color: .teal, selection: .centres),
    TabItem(name: "Reports", icon: "heart.text.square", color: .blue, selection: .reports),
    TabItem(name: "Chat", icon: "message.and.waveform", color: .red, selection: .chat),
    TabItem(name: "Projects", icon: "folder.badge.gearshape", color: .pink, selection: .projects)
]

enum Tab: String {
    case centres
    case reports
    case chat
    case projects
}
