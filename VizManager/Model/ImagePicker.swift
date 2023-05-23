//
//  ImagePicker.swift
//  PhotoList
//
//  Created by Öznur Köse on 7.04.2023.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var images: [UIImage]

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 0
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            for image in results {
                let provider = image.itemProvider
                if provider.canLoadObject(ofClass: UIImage.self) {
                    provider.loadObject(ofClass: UIImage.self) { newImage, error in
                    if let error = error {
                        print("Can't load image \(error.localizedDescription)")
                    } else if let image = newImage as? UIImage {
                        print("---image appending")
                        self.parent.images.append(image)
                    }
                }
            } else {
                print("Can't load asset")
                   }
            }
            picker.dismiss(animated: true)
        
        }
    }
}
