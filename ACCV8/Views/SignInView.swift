//
//  SignInView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 08/08/22.
//

import SwiftUI
import RealmSwift
import AuthenticationServices

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    @State var circleInitialY = CGFloat.zero
    @State var circleY = CGFloat.zero
    @FocusState var isEmailFocused: Bool
    @FocusState var isPasswordFocused: Bool
    @State var appear = [false, false, false]
    @AppStorage("isLogged") var isLogged = false
    @State private var signupToggle = false
    @State private var isLoggingIn = false
    @State private var showAlertToggle = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State var error: Error?
    @State var signInHandler: SignInWithAppleButtonCoordinator?
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
                VStack(alignment: .leading, spacing: 20) {
                    Text(signupToggle ? "Sign Up" : "Sign In")
                        .font(.largeTitle).bold()
                        .blendMode(.overlay)
                        .slideFadeIn(show: appear[0], offset: 30)
                    
                    Text("Access to Artemis Cardiac Care is restricted to Staff and Partners")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .slideFadeIn(show: appear[1], offset: 20)
                    
                    TextField("Email address", text: $email)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .customField(icon: "envelope.open.fill")
                        .overlay(
                            GeometryReader { proxy in
                                let offset = proxy.frame(in: .named("stack")).minY + 32
                                Color.clear.preference(key: CirclePreferenceKey.self, value: offset)
                            }
                            .onPreferenceChange(CirclePreferenceKey.self) { value in
                                circleInitialY = value
                                circleY = value
                            }
                        )
                        .focused($isEmailFocused)
                        .onChange(of: isEmailFocused) { isEmailFocused in
                            if isEmailFocused {
                                withAnimation {
                                    circleY = circleInitialY
                                }
                            }
                        }
                        .slideFadeIn(show: appear[2], offset: 10)
                    
                    SecureField("Password", text: $password)
                        .textContentType(.password)
                        .customField(icon: "key.fill")
                        .focused($isPasswordFocused)
                        .onChange(of: isPasswordFocused, perform: { isPasswordFocused in
                            if isPasswordFocused {
                                withAnimation {
                                    circleY = circleInitialY + 70
                                }
                            }
                        })
                        .slideFadeIn(show: appear[2], offset: 10)
                    Button (action:{
                        isLoggingIn = true
                        Task {
                            await signUp(email: email, password: password)
                            isLoggingIn = false
                        }
                    }, label: {
                        AngularButton(title: signupToggle ? "Create account" : "Sign in")
                })
                .buttonStyle(.plain)
                    
                    if signupToggle {
                        Text("By clicking on Sign up, you agree to our Terms of service and Privacy policy.")
                            .font(.footnote)
                            .foregroundColor(.primary.opacity(0.7))
                    }
                    Divider()
                    
                    Button(action: {
                        withAnimation {
                            signupToggle.toggle()
                        }
                    }, label: {
                    HStack {
                        Text(signupToggle ? "Already have an account?" : "Don't have an account?")
                            .font(.footnote)
                            .foregroundColor(.primary.opacity(0.7))
                        .accentColor(.primary.opacity(0.7))
                        GradientText(text: signupToggle ? "Sign in" : "Sign up")
                            .font(Font.footnote.bold())
                    }
                    })
                    .buttonStyle(.plain)
                    if !signupToggle {
                        Button(action: {
                            self.sendPasswordResetEmail()
                        }, label: {
                            HStack(spacing: 4) {
                                Text("Forgot password?")
                                    .font(.footnote)
                                    .foregroundColor(.primary.opacity(0.7))
                                GradientText(text: "Reset Password")
                                    .font(Font.footnote.bold())
                            }
                        })
                        .buttonStyle(.plain)
                    }
                    
                    Button(action: {
                        signInHandler = SignInWithAppleButtonCoordinator()
                        signInHandler?.signInWithApple()
                    }, label: {
                        SignInWithAppleButton()
                            .frame(height: 50)
                            .cornerRadius(16)
                    })
                    .buttonStyle(.plain)
                }
                .coordinateSpace(name: "stack")
                .padding(20)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .backgroundColor(opacity: 0.4)
                .cornerRadius(30)
                .background(
                    VStack {
                        Circle().fill(.blue).frame(width: 68, height: 68)
                            .offset(x: 0, y: circleY)
                            .scaleEffect(appear[0] ? 1 : 0.1)
                    }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                )
                .modifier(OutlineModifier(cornerRadius: 30))
            .onAppear { animate() }
            .background(
                Image("Blob 1")
                    .offset(x: 170, y: -130)
                    .accessibility(hidden: true)
            )
            .alert(isPresented: $showAlertToggle, content: {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .cancel())
            })
            .padding(EdgeInsets(top: 40, leading: 20, bottom: 40, trailing: 20))
            
        }
    }
    
    func login(email: String, password: String) async {
        do {
            let user = try await accApp.login(credentials: Credentials.emailPassword(email: email, password: password))
            print("Successfully logged in user: \(user)")
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        } catch {
            print("Failed to log in user: \(error.localizedDescription)")
            alertTitle = "Artemis Cardiac Care \n Failed to Sign In!"
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
            alertTitle = "Artemis Cardiac Care \n Failed to Register!"
            alertMessage = error.localizedDescription
            showAlertToggle.toggle()
            self.error = error
        }
        } else {
            await login(email: email, password: password)

        }
    }
    func animate() {
        withAnimation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8).delay(0.2)) {
            appear[0] = true
        }
        withAnimation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8).delay(0.4)) {
            appear[1] = true
        }
        withAnimation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8).delay(0.6)) {
            appear[2] = true
        }
    }
    func sendPasswordResetEmail() {
        accApp.emailPasswordAuth.sendResetPasswordEmail(email: email)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
