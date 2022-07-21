//
//  SignInWithAppleButton.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 30/06/22.
//

import SwiftUI
import AuthenticationServices


struct SignInWithAppleButton: UIViewRepresentable {
    typealias UIViewType = ASAuthorizationAppleIDButton
    func makeUIView(context: Context) -> UIViewType {
        return ASAuthorizationAppleIDButton(type: .continue, style: .black)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
