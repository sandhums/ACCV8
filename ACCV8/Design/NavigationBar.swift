//
//  NavigationBar.swift
//  iOS15
//
//  Created by Meng To on 2021-07-16.
//

import SwiftUI
import RealmSwift

struct NavigationBar: View {
    var title = ""
    @Binding var contentHasScrolled: Bool
    @Environment(\.realm) var realm
    @EnvironmentObject var model: Model
    @AppStorage("showAccount") var showAccount = false
    @AppStorage("isLogged") var isLogged = false
    @ObservedResults(Reps.self) var users
//    @ObservedRealmObject var user: Reps
    var body: some View {
     
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .background(.ultraThinMaterial)
                .ignoresSafeArea()
                .frame(maxHeight: .infinity, alignment: .top)
                .blur(radius: contentHasScrolled ? 10 : 0)
                .opacity(contentHasScrolled ? 1 : 0)
            
            Text(title)
                .animatableFont(size: contentHasScrolled ? 22 : 34, weight: .bold)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .opacity(contentHasScrolled ? 0.7 : 1)
            
            HStack(spacing: 16) {
               LogoutButton(user: Reps())
                Button {
                    withAnimation {
                        if isLogged {
                            showAccount = true
                        } else {
                            model.showModal = true
                        }
                    }
                } label: {
                    avatar
                }
                .accessibilityElement()
                .accessibilityLabel("Account")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding()
        }
       
        .offset(y: model.showNav ? 0 : -120)
        .accessibility(hidden: !model.showNav)
        .offset(y: contentHasScrolled ? -16 : 0)
    }
       
 
    @ViewBuilder
    var avatar: some View {
        if isLogged {
            if let user = users.first {
            UserAvatarView(
                photo: user.userPreferences?.avatarImage,
                online: true)
            }
        } else {
            LogoView(image: "Avatar Default")
        }
        }
    }



struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(contentHasScrolled: .constant(false))
            .environmentObject(Model())
    }
}
