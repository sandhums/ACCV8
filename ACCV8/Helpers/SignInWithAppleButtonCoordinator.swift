//
//  SignInWithAppleButtonCoordinator.swift
//
//  Created by Manjinder Sandhu on 10/8/22.
//

import Foundation
import AuthenticationServices
import CryptoKit
import FirebaseAuth
import RealmSwift

class SignInWithAppleButtonCoordinator: NSObject {
    private var currentNonce: String?
    
    func signInWithApple() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let nonce = randomNonceString()
        currentNonce = nonce
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        return hashString
    }
    
}

//extension SignInWithAppleButtonCoordinator: ASAuthorizationControllerDelegate {
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
//            guard let nonce = currentNonce else {
//                fatalError("Invalid state: A login callback was received, but no login request was sent.")
//            }
//            guard let appleIDToken = appleIDCredential.identityToken else {
//                print("Unable to fetch identity token")
//                return
//            }
//            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
//                print("Unable to serialise token string from data: \(appleIDToken.debugDescription)")
//                return
//            }
//
//            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
//            Auth.auth().signIn(with: credential) { (authResult, error) in
//                if error != nil {
//                    print(error!.localizedDescription)
//                    return
//                } else {
//                    print(authResult)
//                }
//            }
//        }
//    }
//}

extension SignInWithAppleButtonCoordinator: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
      
      switch authorization.credential {
      case let appleIDCredential as ASAuthorizationAppleIDCredential:
          
          // Create an account in your system.
          let userIdentifier = appleIDCredential.user
          let firstName = appleIDCredential.fullName?.givenName ?? ""
          let lastName = appleIDCredential.fullName?.familyName ?? ""
//          let fullName = appleIDCredential.fullName
          let email = appleIDCredential.email
          
          let identityToken = String(data: appleIDCredential.identityToken ?? Data(), encoding: .utf8)
          let nonce = currentNonce
          let app = App(id: "accv8-vofbt")
          
          // Fetch IDToken via the Apple SDK
          let credentials = Credentials.apple(idToken: identityToken ?? "")
          app.login(credentials: credentials) { (result) in
              switch result {
              case .failure(let error):
                  print("Login failed: \(error.localizedDescription)")
              case .success(let user):
                  print("Successfully logged in as user \(user)")
              }
          }
      case let passwordCredential as ASPasswordCredential:
          break
      default:
          break
      }
    }

}
