//
//  DocumentPicker.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/25.
//

import Foundation
import SwiftUI
import UIKit

struct DocumentPicker : UIViewControllerRepresentable {
    
    var types = ["public.image", "public.jpeg", "public.png", "public.pdf",
                   "public.text", "public.video", "public.audio", "public.text",
                   "public.data", "public.zip-archive"]
    
    var callback : ([URL]?) -> Void
    
    @Environment(\.presentationMode) var presentationMode
    


    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    func makeUIViewController(context: Context) ->  UIDocumentPickerViewController {
//        let types = ["public.image", "public.jpeg", "public.png", "public.pdf",
//                       "public.text", "public.video", "public.audio", "public.text",
//                       "public.data", "public.zip-archive"]
        let picker = UIDocumentPickerViewController(documentTypes: types, in: .import)
        picker.allowsMultipleSelection = true
        picker.modalPresentationStyle = .fullScreen
        picker.delegate = context.coordinator
        return picker
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    
    class Coordinator : NSObject, UIDocumentPickerDelegate {
        var parent : DocumentPicker
        
        init(_ parent : DocumentPicker){
            self.parent = parent
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            self.parent.callback(nil)
            print("Cancelled picking document")
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            self.parent.callback(urls)
            self.parent.presentationMode.wrappedValue.dismiss()
        }
    }

}
