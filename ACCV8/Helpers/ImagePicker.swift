//
//  ImagePicker.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 30/06/22.
//

import SwiftUI
import RealmSwift

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
//    @Binding var thumbImage: UIImage?
    private let maximumImageSize = 1024 * 1024

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.editedImage] as? UIImage {
                guard let data = uiImage.jpegData(compressionQuality: 0.5),
                     let compressedImage = UIImage(data: data) else {
                    return
                }
                parent.image = compressedImage.thumbnail(size: 120)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
//    private func compressImageIfNeeded(image: UIImage) -> UIImage? {
//        let resultImage = image
//        
//        if let data = resultImage.jpegData(compressionQuality: 1) {
//            if data.count > maximumImageSize {
//                
//                let neededQuality = CGFloat(maximumImageSize) / CGFloat(data.count)
//                if let resized = resultImage.jpegData(compressionQuality: neededQuality),
//                   let resultImage = UIImage(data: resized) {
//                    
//                    return resultImage
//                } else {
//                    print("Fail to resize image")
//                }
//            }
//        }
//        return resultImage
//    }
    
}
extension UIImage {
    func genThumb(size: CGFloat) -> UIImage? {
        var thumbnail: UIImage?
        guard let imageData = self.pngData() else {
            return nil
        }
        let options = [
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceThumbnailMaxPixelSize: size] as CFDictionary
        
        imageData.withUnsafeBytes { ptr in
            if let bytes = ptr.baseAddress?.assumingMemoryBound(to: UInt8.self),
               let cfData = CFDataCreate(kCFAllocatorDefault, bytes, imageData.count),
               let source = CGImageSourceCreateWithData(cfData, nil),
               let imageReference = CGImageSourceCreateThumbnailAtIndex(source, 0, options) {
                thumbnail = UIImage(cgImage: imageReference)
            }
        }
        
        return thumbnail
    }
}
