//
//  ResultViewModel.swift
//  AIImageGeneratorApp
//
//  Created by Saheem Hussain on 03/11/23.
//

import Foundation
import SwiftUI

class ResultViewModel: NSObject, ObservableObject {
 
    @Published var isSaving = false
    
    var imageArray: [UIImage] = []
    var imageSaved = false
    
    func saveImage(image: UIImage) {
        // Show loader
        isSaving = true
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        // Hide loader on the main thread
        DispatchQueue.main.async {
            self.isSaving = false

            if let error = error {
                // Handle the error
                print("Error saving image: \(error.localizedDescription)")
            } else {
                // Image saved successfully
//                imageSaved = true
                print("Image saved to photo album")
            }
        }
    }
}
