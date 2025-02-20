//
//  ImagePicker.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/20.
//

import SwiftUI

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var path: NavigationPath
    @Binding var picture: UIImage?
    
    func makeUIViewController(context: Context) ->  UIImagePickerController {
        let mediaPicker = UIImagePickerController()
        mediaPicker.delegate = context.coordinator
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            mediaPicker.sourceType = .camera
            mediaPicker.mediaTypes = ["public.image"]
            mediaPicker.allowsEditing = false
            mediaPicker.cameraCaptureMode = .photo
        } else {
            print("The media is not available")
//            path.removeLast()
        }
        return mediaPicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeCoordinator() -> ImagePickerCoordinator {
        ImagePickerCoordinator(path: $path, picture: $picture)
    }
}

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var path: NavigationPath
    @Binding var picture: UIImage?
    
    init(path: Binding<NavigationPath>, picture: Binding<UIImage?>) {
        self._path = path
        self._picture = picture
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let newpicture = info[.originalImage] as? UIImage {
            picture = newpicture
        }
        path = NavigationPath()
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        path = NavigationPath()
    }
}
