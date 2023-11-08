//
//  ContentViewModel.swift
//  AIImageGeneratorApp
//
//  Created by Saheem Hussain on 03/11/23.
//

import Foundation
import OpenAIKit
import SwiftUI

final class ContentViewModel: ObservableObject {
    
    @Published var text = String()
    @Published var noOfImages = 1
    @Published var resolution: ImageResolutions = .medium
    @Published var styleSelected: Style = .noStyle
    
    @Published var image: UIImage?
    @Published var error: String?
    
    @Published var isPresented: Bool = false
    @Published var isImageLoading: Bool = false
    @Published var presentStyleSheet = false
    @Published var nextScreen = false
    
    var textLimit: Int = 200
    let openai = OpenAIKitManager.shared
    
    func generateImage() {

        if !text.trimmingCharacters(in: .whitespaces).isEmpty {
            isImageLoading = true
            error = nil
            isPresented = false
            
            Task {
                let result = await openai.generateImage(promt: generatePrompt(),
                                                        resolution: resolution,
                                                        numberOfImages: noOfImages)
                DispatchQueue.main.async {
                    if let imageArray = result.0 {
                        self.image = imageArray[0]
                        self.nextScreen = true
                    } else if let error = result.1 {
                        self.error = error.error.message
                        self.isPresented = true
                    }
                    self.isImageLoading = false
                }
            }
        } else {
            isPresented = true
            error = "Please enter prompt."
        }
        
    }
    
    func variation(image: UIImage) {
        
        isImageLoading = true
        error = nil
        isPresented = false
        
        Task {
            let result = await openai.variation(image: image, numberOfImages: noOfImages, resolution: resolution)
            DispatchQueue.main.async {
                if let imageArray = result.0 {
                    self.image = imageArray[0]
                } else if let error = result.1 {
                    self.error = error.error.message
                    self.isPresented = true
                }
                self.isImageLoading = false
            }
        }
    }
    
    func generatePrompt() -> String {
        
        if styleSelected == .noStyle {
            return text
        } else {
            return "\(text) \(styleSelected.rawValue)"
        }
    }
    
    func presentStyleView() {
        presentStyleSheet.toggle()
    }

    func sortImageStyles() {
        if let index = ImageStyle.data.firstIndex(where: { $0.style == styleSelected }) {
            let data = ImageStyle.data.remove(at: index)
            ImageStyle.data.insert(data, at: 1)
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.endEditing(true)
    }
}
