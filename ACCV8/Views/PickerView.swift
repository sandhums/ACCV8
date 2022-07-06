//
//  PickerView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 05/07/22.
//

import SwiftUI
import RealmSwift

struct PickerView: View {
    @State private var photo: Photo?
    @State private var photoAdded = false
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear(perform: showPhotoTaker)
    }
    private func showPhotoTaker() {
        PhotoCaptureController.show(source: .camera) { controller, photo in
            self.photo = photo
            photoAdded = true
            controller.hide()
        }
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView()
    }
}
