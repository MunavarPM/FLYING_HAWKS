//
//  ImagePicker.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 02/08/23.
//

import Foundation
import SwiftUI


struct ImagePickerView:UIViewControllerRepresentable{
    
    @Binding var selectedImage:UIImage
    @Environment(\.dismiss) private var dismiss
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator:NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        var parent:ImagePickerView
        
        init(_ parent:ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                parent.selectedImage = image
            }
            parent.dismiss()
        }
        
    }
    func makeUIViewController(context: Context) -> some UIViewController {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = context.coordinator
            return imagePicker
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
