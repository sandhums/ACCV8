//
//  AccountView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 01/07/22.
//

import SwiftUI
import RealmSwift

struct AccountView: View {
    @State var isPinned = false
    @State var isDeleted = false
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isLogged") var isLogged = false
    @AppStorage("shouldShareLocation") var shouldShareLocation = false
    @Environment(\.realm) var realm
    @ObservedRealmObject var user: Reps
    @ObservedResults(Centre.self) var centres

    @State private var photo: Photo?
    @State private var photoAdded = false
   
    
    
    @State private var selectedCentre = ""
   
    @State private var editingDisplayNameTextfield = false
    @State private var displayNameIconBounce = false
    @State private var displayName = ""
    @State private var editingFirstNameTextfield = false
    @State private var firstNameIconBounce = false
    @State private var firstName = ""
    @State private var editingLastNameTextfield = false
    @State private var lastNameIconBounce = false
    @State private var lastName = ""
    @State private var editingUserMobileTextfield = false
    @State private var userMobileIconBounce = false
    @State private var userMobile = ""
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var inputThumb: UIImage?
    @State private var showActionAlert = false
    @State private var alertTitle = "Settings Saved!"
    @State private var alertMessage = "Your changes have been saved"

    private let generator = UISelectionFeedbackGenerator()
    var body: some View {
        HStack() {
            VStack(alignment: .leading, spacing: 14) {
                VStack(alignment: .leading, spacing: 14) {
                    Text("Profile Settings")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.white.opacity(0.1))
                    if let photo = photo {
                        AvatarButton(photo: photo) {
                            self.showPhotoTaker()
                        }
                    }
                    if photo == nil {
                        Button(action: { self.showPhotoTaker() }) {
                            GradientText(text: "Choose Photo")
                        }
                    }

                }
                
                // Display Name Text Field
                GradientTextfield(editingTextfield: $editingDisplayNameTextfield, textfieldString: $displayName, iconBounce: $displayNameIconBounce, textfieldPlaceholder: "Display Name", textfieldIconString: "textformat.alt")
                    .autocapitalization(.words)
                    .textContentType(.name)
                    .disableAutocorrection(true)
                // First Name Text Field
                GradientTextfield(editingTextfield: $editingFirstNameTextfield, textfieldString: $firstName, iconBounce: $firstNameIconBounce, textfieldPlaceholder: "First Name", textfieldIconString: "textformat.alt")
                    .autocapitalization(.words)
                    .textContentType(.name)
                    .disableAutocorrection(true)
                
                // Last Name Field
                GradientTextfield(editingTextfield: $editingLastNameTextfield, textfieldString: $lastName, iconBounce: $lastNameIconBounce, textfieldPlaceholder: "Last Name", textfieldIconString: "textformat.alt")
                    .autocapitalization(.words)
                    .textContentType(.name)
                    .disableAutocorrection(true)
                
                // Mobile Field
                GradientTextfield(editingTextfield: $editingUserMobileTextfield, textfieldString: $userMobile, iconBounce: $userMobileIconBounce, textfieldPlaceholder: "Mobile", textfieldIconString: "iphone")
                    .autocapitalization(.none)
                    .keyboardType(.webSearch)
                    .disableAutocorrection(true)
                
                // Centre Selection
               Text("Select Centre")
                    .foregroundColor(.purple)
                Picker(selection: $selectedCentre, label: Text("Select Centre")) {
                    Text("Nothing Selected")
                    ForEach(centres, id: \.self) { centre in
                        Text(centre.centreName).tag(centre.centreName)
                    }
                }
                .onAppear(perform: initData)
                .pickerStyle(.menu)
                .accentColor(.white)
                VStack {
                Toggle(isOn: $shouldShareLocation, label: {
                    Text("Share Location")
                })
                    .onChange(of: shouldShareLocation) { value in
                        if value {
                            _ = LocationHelper.currentLocation
                        }
                    }
                OnlineAlertSettings()
                    HStack {
                GradientButton(buttonTitle: "Save Settings") {
                    generator.selectionChanged()
                    saveProfile()
                }
                        GradientButton(buttonTitle: "Cancel") {
                           
                            presentationMode.wrappedValue.dismiss()
                    }
                }
                }
                .foregroundColor(.white
                )
                Spacer()
            }
            .padding()
            
            Spacer()
        }
        .task {
            do {
            try await setSubscription()
            } catch {
                
            }
        }
        .background(
            Color("settingsBackground")
                .edgesIgnoringSafeArea(.all)
        )
        .alert(isPresented: $showActionAlert, content: {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .cancel())
        })
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
        PhotoCaptureController.show(source: .camera) { controller, photo in
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


