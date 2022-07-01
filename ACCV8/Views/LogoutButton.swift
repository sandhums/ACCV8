//
//  LogoutButton.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 29/06/22.
//

import SwiftUI
import RealmSwift

struct LogoutButton: View {
    @State var isLoggingOut = false
    @State var error: Error?
    @State var errorMessage: ErrorMessage? = nil
    
    var body: some View {
        if isLoggingOut {
            ProgressView()
        }
        Button("Log Out") {
            guard let user = accApp.currentUser else {
                return
            }
            isLoggingOut = true
            Task {
                await logout(user: user)
                isLoggingOut = false
            }
        }.disabled(accApp.currentUser == nil || isLoggingOut)
        .alert(item: $errorMessage) { errorMessage in
            Alert(
                title: Text("Failed to log out"),
                message: Text(errorMessage.errorText),
                dismissButton: .cancel()
            )
        }
    }
    
    func logout(user: User) async {
        do {
            try await user.logOut()
            print("Successfully logged user out")
        } catch {
            print("Failed to log user out: \(error.localizedDescription)")
            self.errorMessage = ErrorMessage(errorText: error.localizedDescription)
        }
    }
}

struct ErrorMessage: Identifiable {
    let id = UUID()
    let errorText: String
}