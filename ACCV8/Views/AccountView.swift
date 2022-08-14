//
//  AccountView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 01/07/22.
//

import SwiftUI
import RealmSwift

struct AccountView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isLogged") var isLogged = false
    @AppStorage("shouldShareLocation") var shouldShareLocation = false
    @Environment(\.realm) var realm
    @ObservedRealmObject var user: Reps
    @ObservedResults(Centre.self) var centres
    
    @State private var photo: Photo?
    @State private var photoAdded = false
    
    
    
    @State private var selectedCentre = ""
    
    @State private var displayName = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var userMobile = ""
    
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            ScrollView {
                HStack() {
                    VStack(alignment: .leading, spacing: 14) {
                        VStack(alignment: .leading, spacing: 14) {
                            HStack {
                                GradientText(text: "Profile Settings")
                                    .font(.title2.bold())
                                    .buttonStyle(.plain)
                                Spacer()
                                Button (action: {
                                    presentationMode.wrappedValue.dismiss()
                                }, label: {
                                    CloseButton()
                                })
                                .buttonStyle(.plain)
                            }
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color.primary.opacity(0.1))
                            if let photo = photo {
                                AvatarButton(photo: photo) {
                                    self.showPhotoTaker()
                                }
                            }
                            if photo == nil {
                                Button(action: { self.showPhotoTaker() }) {
                                    GradientText(text: "Choose Photo")
                                }
                                .buttonStyle(.plain)
                            }
                            
                        }
                        
                        // Display Name Text Field
                        TextField("Display Name", text: $displayName)
                            .textContentType(.name)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .customField(icon: "eye")
                        
                        // First Name Text Field
                        TextField("First Name", text: $firstName)
                            .textContentType(.name)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .customField(icon: "textformat.alt")
                        
                        // Last Name Field
                        TextField("Last Name", text: $lastName)
                            .textContentType(.name)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .customField(icon: "textformat.alt")
                        // Mobile Field
                        TextField("Mobile", text: $userMobile)
                            .textContentType(.name)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .customField(icon: "iphone")
                        // Centre Selection
                        Text("Select Centre")
                            .foregroundColor(.primary)
                        Picker(selection: $selectedCentre, label: Text("Select Centre")) {
                            Text("Nothing Selected")
                            ForEach(centres, id: \.self) { centre in
                                Text(centre.centreName).tag(centre.centreName)
                            }
                        }
                        .onAppear(perform: initData)
                        .pickerStyle(.menu)
                        .accentColor(.primary)
                        VStack {
                            HStack {
                                Button (action:{
                                    saveProfile()
                                }, label: {
                                    AngularButton(title: "Save")
                                })
                                .buttonStyle(.plain)
                                LogoutButton(user: user)
                            }
                            Toggle(isOn: $shouldShareLocation, label: {
                                Text("Share Location")
                            })
                            .onChange(of: shouldShareLocation) { value in
                                if value {
                                    _ = LocationHelper.currentLocation
                                }
                            }
                            OnlineAlertSettings()
                        }
                        .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding()
                    Spacer()
                }}
            .task {
                do {
                    try await setSubscription()
                } catch {
                    
                }
            }
            .background(
                Image("Blob 1")
                    .offset(x: 70, y: -50)
                    .accessibility(hidden: true)
            )
        }
    }
    private func saveProfile() {
        let userPreferences = UserPreferences()
        userPreferences.displayName = self.displayName
        if photoAdded {
            guard let newPhoto = photo else {
                print("Missing photo")
                return
            }
            userPreferences.avatarImage = newPhoto
        } else {
            userPreferences.avatarImage = Photo(photo)
        }
        $user.userPreferences.wrappedValue = userPreferences
        $user.presenceState.wrappedValue = .onLine
        $user.firstName.wrappedValue = self.firstName
        $user.lastName.wrappedValue = self.lastName
        $user.userMobile.wrappedValue = self.userMobile
        $user.centreName.wrappedValue = self.selectedCentre
        print("settings saved")
        presentationMode.wrappedValue.dismiss()
    }
    private func initData() {
        displayName = user.userPreferences?.displayName ?? "Unknown"
        photo = user.userPreferences?.avatarImage
        firstName = user.firstName
        lastName = user.lastName
        userMobile = user.userMobile
        selectedCentre = user.centreName
    }
    private func showPhotoTaker() {
        PhotoCaptureController.show(source: .photoLibrary) { controller, photo in
            self.photo = photo
            photoAdded = true
            controller.hide()
        }
    }
    private func setSubscription() async throws {
        let subscriptions = realm.subscriptions
        let foundSubscription = subscriptions.first(named: "allCentres")
        try await subscriptions.update {
            if foundSubscription != nil {
                foundSubscription!.updateQuery(toType: Centre.self)
                print("updating query allCentres")
            } else {
                subscriptions.append(
                    QuerySubscription<Centre>(name: "allCentres"))
                print("appending query allCentres")
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(user: Reps())
        
    }
}


