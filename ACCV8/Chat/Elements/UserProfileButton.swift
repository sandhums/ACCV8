//
//  UserProfileButton.swift
//  ACCv5
//
//  Created by Manjinder Sandhu on 27/05/22.
//

import SwiftUI

struct UserProfileButton: View {
//    @EnvironmentObject var state: AppState

    let action: () -> Void

    var body: some View {
        Button("Profile", action: action)
//        .disabled(state.shouldIndicateActivity)
    }
}

struct UserProfileButton_Previews: PreviewProvider {
    static var previews: some View {
        return AppearancePreviews(
            UserProfileButton(action: { })
        )
        .padding()
        .previewLayout(.sizeThatFits)
       
    }
}
