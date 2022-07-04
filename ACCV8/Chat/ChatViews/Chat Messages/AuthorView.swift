//
//  AuthorView.swift
//  ACCv5
//
//  Created by Manjinder Sandhu on 27/05/22.
//

import SwiftUI

import RealmSwift

struct AuthorView: View {
//    @EnvironmentObject var state: AppState
    @Environment(\.realm) var realm
    @ObservedResults(Chatster.self) var chatsters
    
    let userName: String
    
    var chatster: Chatster? {
        chatsters.filter("userName = %@", userName).first
    }
    
    private enum Dimensions {
        static let authorHeight: CGFloat = 25
        static let padding: CGFloat = 4
    }
    
    var body: some View {
        if let author = chatster {
            HStack {
                if let photo = author.avatarImage {
                    AvatarThumbNailView(photo: photo, imageSize: Dimensions.authorHeight)
                }
                if let name = author.displayName {
                    Text(name)
                    .font(.caption)
                } else {
                    Text(author.userName)
                        .font(.caption)
                }
                Spacer()
            }
            .onAppear(perform: setSubscription)
            .frame(maxHeight: Dimensions.authorHeight)
            .padding(Dimensions.padding)
        }
    }
    
    private func setSubscription() {
        let subscriptions = realm.subscriptions
        subscriptions.update {
            if let currentSubscription = subscriptions.first(named: "all_chatsters") {
                currentSubscription.updateQuery(toType: Chatster.self) { chatster in
                    chatster.userName != ""
                }

            } else {
                subscriptions.append(QuerySubscription<Chatster>(name: "all_chatsters") { chatster in
                    chatster.userName != ""
                })
            }
        }
    }
}

struct AuthorView_Previews: PreviewProvider {
    static var previews: some View {
        Realm.bootstrap()
        
        return AppearancePreviews(AuthorView(userName: "rod@contoso.com"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
