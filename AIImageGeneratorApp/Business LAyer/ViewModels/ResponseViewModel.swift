//
//  ResponseViewModel.swift
//  AIImageGeneratorApp
//
//  Created by Saheem Hussain on 09/11/23.
//

import Foundation
import SwiftUI

class ResponseViewModel: NSObject, ObservableObject {
 
    @Published var presenAlert = false
    @Published var message = String()
    
    func saveImage(image: UIImage) {
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        DispatchQueue.main.async {

            if let error = error {
                // Handle the error
                print("Error saving image: \(error.localizedDescription)")
                self.message = AppConstants.errorSaving
            } else {
                print("Image saved to photo album")
                self.message = AppConstants.imageSaved
            }
            
            self.presenAlert = true
        }
    }
}
