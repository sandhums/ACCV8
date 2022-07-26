//
//  Model.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 30/06/22.
//

import SwiftUI
import Combine
import RealmSwift

class Model: ObservableObject {
    @Published var error: String?
    @Published var busyCount = 0
    var shouldIndicateActivity: Bool {
        get {
            return busyCount > 0
        }
        set (newState) {
            if newState {
                busyCount += 1
            } else {
                if busyCount > 0 {
                    busyCount -= 1
                } else {
                    print("Attempted to decrement busyCount below 1")
                }
            }
        }
    }

    var loggedIn: Bool {
        accApp.currentUser != nil && accApp.currentUser?.state == .loggedIn
    }

    init() {
        accApp.currentUser?.logOut { _ in
        }
    }
    // Tab Bar
    @Published var showTab: Bool = true
    
    // Navigation Bar
    @Published var showNav: Bool = true
    
    // Modal
    @Published var selectedModal: Modal = .signUp
    @Published var showModal: Bool = false
    @Published var dismissModal: Bool = false
    
    // Detail View
    @Published var showDetail: Bool = false
    @Published var selectedCentre: Int = 0
}

enum Modal: String {
    case signUp
    case signIn
}
