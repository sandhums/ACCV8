//
//  SetUserProfileView.swift
//  ACCv5
//
//  Created by Manjinder Sandhu on 27/05/22.
//

import SwiftUI

import RealmSwift

struct SetUserProfileView: View {
    @AppStorage("shouldShareLocation") var shouldShareLocation = false
    @AppStorage("isLogged") var isLogged = false
    @Environment(\.realm) var realm
    @ObservedRealmObject var user: Reps
    @ObservedResults(Centre.self) var centres
    @Binding var isPresented: Bool

    
    @State private var displayName = ""
    @State private var photo: Photo?
    @State private var photoAdded = false
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var userMobile = ""
    @State private var selectedCentre = ""
  
    
    var body: some View {
   
        Form {
            Section {
                if let photo = photo {
                    AvatarButton(photo: photo) {
                        self.showPhotoTaker()
                    }
                }
                if photo == nil {
                    Button(action: { self.showPhotoTaker() }) {
                        Text("Add Photo")
                    }
                }
                TextField("Display Name", text: $displayName)
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField( "Mobile Number", text: $userMobile)
                Text("Select Centre")
                Picker(selection: $selectedCentre, label: Text("Select Centre")) {
                    Text("Nothing Selected")
                    ForEach(centres, id: \.self) { centre in
                        Text(centre.centreName).tag(centre.centreName)
                    }
                }
                .onAppear(perform: initData)
                .pickerStyle(.menu)
                .accentColor(.white)
            
            } header: {
                SectionTextAndImage(name: "User Profile", image: "person.fill")
            }
            .listRowBackground(Color.purple)
            .foregroundColor(.white)
            Section {
                Toggle(isOn: $shouldShareLocation, label: {
                    Text("Share Location")
                })
                    .onChange(of: shouldShareLocation) { value in
                        if value {
                            _ = LocationHelper.currentLocation
                        }
                    }
                OnlineAlertSettings()
            } header: {
                SectionTextAndImage(name: "Device Settings", image: "lock.iphone")
            }
            .listRowBackground(Color.indigo)
            .foregroundColor(.white)
            HStack {
            CallToActionButton(title: "Save User Profile", action: saveProfile)
            Button("Cancel") {
//                isPresented.toggle()
            }
//            .buttonStyle(ButtonStyleInitialView())
            }
        }
        .onAppear {
            setSubscription()
        }
    
//        .navigationBarItems(
//            leading: Button(action: { isPresented = false }) { BackButton() },
//            trailing: LogoutButton(user: user, userID: $userID, action: { isPresented = false }))
        .padding()
        .navigationBarTitle("Edit Profile", displayMode: .inline)
        .tint(.white)
    
    }
    
    private func initData() {
        displayName = user.userPreferences?.displayName ?? "Unknown"
        photo = user.userPreferences?.avatarImage
        firstName = user.firstName
        lastName = user.lastName
        userMobile = user.userMobile
        selectedCentre = user.centreName
    }
    
    private func saveProfile() {
        let userPreferences = UserPreferences()
        userPreferences.displayName = displayName
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
        $user.firstName.wrappedValue = firstName
        $user.lastName.wrappedValue = lastName
        $user.userMobile.wrappedValue = userMobile
        $user.centreName.wrappedValue = selectedCentre
//        isPresented.toggle()
    }
    
    private func showPhotoTaker() {
        PhotoCaptureController.show(source: .camera) { controller, photo in
            self.photo = photo
            photoAdded = true
            controller.hide()
        }
    }
    private func setSubscription() {
        let subscriptions = realm.subscriptions
        subscriptions.update {
            if let currentSubscription = subscriptions.first(named: "all_centres") {
                currentSubscription.updateQuery(toType: Centre.self) { centre in
                    centre.centreName != ""
                }

            } else {
                subscriptions.append(QuerySubscription<Centre>(name: "all_centres") { centre in
                    centre.centreName != ""
                })
            }
        }
    }
}
struct SectionTextAndImage: View {
    var name: String
    var image: String
    var body: some View {
        HStack {
            Image(systemName: image).padding(.trailing)
            Text(name)
        }
        //.padding()
        .font(.caption)
        .foregroundColor(Color.purple)
    }
}
struct SetUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SetUserProfileView(user: Reps(), isPresented: .constant(true))
    }
}
