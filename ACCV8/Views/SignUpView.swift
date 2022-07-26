//
//  SignUpView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 30/06/22.
//

import SwiftUI
import AudioToolbox
import RealmSwift
import AuthenticationServices

struct SignUpView: View {
    @State private var email = ""
    @State private var editingEmailTextfield = false
    @State private var password = ""
    @State private var editingPasswordTextfield = false
    @State private var emailIconBounce: Bool = false
    @State private var passwordIconBounce: Bool = false
    @State private var isLoggingIn = false
    @State var error: Error?
    @State private var signupToggle = false
    @State private var showAlertToggle = false
    @State private var fadeToggle = true
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var rotationAngle = 0.0
    @AppStorage("isLogged") var isLogged = false
   
    
    private let generator = UISelectionFeedbackGenerator()
    
    var body: some View {
        ZStack {
            Image(signupToggle ? "background-3" : "background-1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .opacity(fadeToggle ? 1.0 : 0.0)
            Color("secondaryBackground")
                .edgesIgnoringSafeArea(.all)
                .opacity(fadeToggle ? 0 : 0.5)
            VStack {
                if isLoggingIn {
                    ProgressView()
                }
                if let error = error {
                    Text("Error: \(error.localizedDescription)")
                }
                VStack(alignment: .leading, spacing: 16) {
                    GradientText(text: signupToggle ? "Sign Up" : "Sign In")
                        .font(Font.largeTitle.bold())
                        .foregroundColor(.primary)
                    Text("Access to Artemis Cardiac Care is restricted to Staff and Partners")
                        .font(.subheadline)
                        .foregroundColor(Color.white.opacity(0.7))
                    HStack(spacing: 12) {
                       TextfieldIcon(iconName: "envelope.open.fill", passedImage: .constant(nil), currentlyEditing: $editingEmailTextfield)
                           .scaleEffect(emailIconBounce ? 1.2 : 1.0)
                        TextField("Email", text: $email){ isEditing in
                            generator.selectionChanged()
                            editingPasswordTextfield = false
                            editingEmailTextfield = isEditing
                            if isEditing {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                                    emailIconBounce.toggle()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now()+0.25) {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                                        emailIconBounce.toggle()
                                    }
                                }
                            }
                        }
                            .colorScheme(.dark)
                            .foregroundColor(Color.white.opacity(0.7))
                            .autocapitalization(.none)
                            .textContentType(.emailAddress)
                    }
                    .frame(height: 52)
                    .overlay(RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white, lineWidth: 1.0)
                        .blendMode(.overlay)
                    )
                    .background(
                        Color("secondaryBackground")
                            .cornerRadius(16)
                            .opacity(0.8)
                    )
                    HStack(spacing: 12) {
                        TextfieldIcon(iconName: "key.fill", passedImage: .constant(nil), currentlyEditing: $editingPasswordTextfield)
                            .scaleEffect(passwordIconBounce ? 1.2 : 1.0)
                        SecureField("Password", text: $password)
                            .colorScheme(.dark)
                            .foregroundColor(Color.white.opacity(0.7))
                            .autocapitalization(.none)
                            .textContentType(.password)
                    }
                    .frame(height: 52)
                    .overlay(RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white, lineWidth: 1.0)
                        .blendMode(.overlay)
                    )
                    .background(
                        Color("secondaryBackground")
                            .cornerRadius(16)
                            .opacity(0.8)
                    )
                    .onTapGesture {
                        generator.selectionChanged()
                        editingPasswordTextfield = true
                        if editingPasswordTextfield {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                                passwordIconBounce.toggle()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.25) {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                                    passwordIconBounce.toggle()
                                }
                            }
                        }
                    }
                    GradientButton(buttonTitle: signupToggle ? "Create account" : "Sign in", buttonAction: {
                        generator.selectionChanged()
                        isLoggingIn = true
                        Task {
                            await signUp(email: email, password: password)
                            isLoggingIn = false
                        }
                    })
                    if signupToggle {
                        Text("By clicking on Sign up, you agree to our Terms of service and Privacy policy.")
                            .font(.footnote)
                            .foregroundColor(Color.white.opacity(0.7))
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.white.opacity(0.1))
                    }
            
                        Button(action: {
                            withAnimation(Animation.easeInOut(duration: 0.35)) {
                                fadeToggle.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                                    withAnimation(.easeInOut(duration: 0.35)) {
                                        self.fadeToggle.toggle()
                                    }
                                }
                            }
                            
                            withAnimation(Animation.easeInOut(duration: 0.7)) {
                                self.rotationAngle += 180
                                signupToggle.toggle()
                            }
                        }, label: {
                            HStack(spacing: 4) {
                                Text(signupToggle ? "Already have an account?" : "Don't have an account?")
                                    .font(.footnote)
                                    .foregroundColor(Color.white.opacity(0.7))
                                GradientText(text: signupToggle ? "Sign in" : "Sign up")
                                    .font(Font.footnote.bold())
                            }
                        })
                    if !signupToggle {
                        Button(action: {
                            self.sendPasswordResetEmail()
                        }, label: {
                            HStack(spacing: 4) {
                                Text("Forgot password?")
                                    .font(.footnote)
                                    .foregroundColor(Color.white.opacity(0.7))
                                GradientText(text: "Reset Password")
                                    .font(Font.footnote.bold())
                            }
                        })
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.white.opacity(0.1))
                        
                        Button(action: {
//                            signInHandler = SignInWithAppleButtonCoordinator()
//                            signInHandler?.signInWithApple()
                        }, label: {
                            SignInWithAppleButton()
                                .frame(height: 50)
                                .cornerRadius(16)
                        })
                    }
                }
                .padding(20)
            }
            .rotation3DEffect(Angle(degrees: self.rotationAngle), axis: (x: 0.0, y: 1.0, z: 0.0))
            .alert(isPresented: $showAlertToggle, content: {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .cancel())
            })
            .background(RoundedRectangle(cornerRadius: 30)
                .stroke(Color.white.opacity(0.2))
                .background(Color("secondaryBackground").opacity(0.5))
                .background(VisualEffectBlur(blurStyle: .systemThinMaterialDark))
                .shadow(color: Color("shadowColor").opacity(0.5), radius: 60, x: 0, y: 30))
            .cornerRadius(30)
            .padding(.horizontal)
            .rotation3DEffect(Angle(degrees: self.rotationAngle), axis: (x: 0.0, y: 1.0, z: 0.0))
        }
    }
    func login(email: String, password: String) async {
        do {
            let user = try await accApp.login(credentials: Credentials.emailPassword(email: email, password: password))
            isLogged = true
            print("Successfully logged in user: \(user)")
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        } catch {
            print("Failed to log in user: \(error.localizedDescription)")
            alertTitle = "Artemis Cardiac Care Alert!"
            alertMessage = error.localizedDescription
            showAlertToggle.toggle()
            self.error = error
        }
    }
    
    /// Registers a new user with the email/password authentication provider.
    func signUp(email: String, password: String) async {
        if signupToggle {
        do {
            try await accApp.emailPasswordAuth.registerUser(email: email, password: password)
            print("Successfully registered user")
            await login(email: email, password: password)
          
        } catch {
            print("Failed to register user: \(error.localizedDescription)")
            alertTitle = "Artemis Cardiac Care Alert!"
            alertMessage = error.localizedDescription
            showAlertToggle.toggle()
            self.error = error
        }
        } else {
            await login(email: email, password: password)

        }
    }
    func sendPasswordResetEmail() {
        
    }
    func appleLogin() {
        // Fetch IDToken via the Apple SDK
        let credentials = Credentials.apple(idToken: "<token>")
        accApp.login(credentials: credentials) { (result) in
            switch result {
            case .failure(let error):
                print("Login failed: \(error.localizedDescription)")
            case .success(let user):
                print("Successfully logged in as user \(user)")
                // Now logged in, do something with user
                // Remember to dispatch to main if you are doing anything on the UI thread
            }
        }

    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
    }
}


