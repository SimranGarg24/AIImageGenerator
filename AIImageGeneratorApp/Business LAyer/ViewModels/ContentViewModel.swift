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
    
    // MARK: - Properties
    @Published var text = String()
    @Published var noOfImages = 1
    @Published var resolution: ImageResolutions = .medium
    @Published var styleSelected: Style = .noStyle
    @Published var imageArray: [UIImage] = [] // for ui
    @Published var image: UIImage?
    @Published var error: String?
    
    @Published var isPresented: Bool = false
    @Published var isImageLoading: Bool = false
    @Published var presentStyleSheet = false
    @Published var nextScreen = false
    @Published var onResponseScreen = false
    @Published var alertpresented = false
    @Published var showToast = false
    
    var textLimit: Int = 1000 // api limit
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 125)),
        GridItem(.adaptive(minimum: 125)),
        GridItem(.adaptive(minimum: 125))
    ]
    
    let openai = OpenAIKitManager.shared
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
    
    // MARK: - Methods
    
    func generateImage() {
        if text.rangeOfCharacter(from: .alphanumerics) == nil {
            isPresented = true
            error = AppConstants.enterprompt
            
        } else if text.count > textLimit {
            showToast = true
            error = AppConstants.wordLimitExceeded
        } else {
            // Background tasks can end in one of two ways:
            // a. When your app has finished doing whatever it set out to do.
            // b. When the system calls the task’s expiry handler.
            
            // Start the background task
            // The beginBackgroundTask method is used to request additional time for the API call to
            // complete even if the app is in the background.
            // beginBackgroundTask(expirationHandler:) doesn’t actually start any sort of background task,
            // but rather it tells the system that you have started some ongoing work that
            // you want to continue even if your app is in the background.
            backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(withName: "APICallBackgroundTask") {
                // Clean up code, called when the task is about to be terminated.
                UIApplication.shared.endBackgroundTask(self.backgroundTaskIdentifier)
                self.backgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
            }
            
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
                        if let image = self.image {
                            self.imageArray.insert(image, at: 0)
                        }
                        self.nextScreen = true
                    } else if let error = result.1 {
                        self.error = error
                        if self.onResponseScreen {
                            self.alertpresented = true
                        } else {
                            self.isPresented = true
                        }
                    }
                    self.isImageLoading = false
                    // You must end every background task that you begin.
                    // Failure to do so will result in your app being killed by the watchdog
                    // End the background task when the API call is done
                    UIApplication.shared.endBackgroundTask(self.backgroundTaskIdentifier)
                    self.backgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
                }
            }
        }
        
    }
    
    func variation(image: UIImage) {
        
        // Start the background task
        // The beginBackgroundTask method is used to request additional time for the API call to
        // complete even if the app is in the background.
        backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(withName: "APIBackgroundTask") {
            // Clean up code, called when the task is about to be terminated.
            UIApplication.shared.endBackgroundTask(self.backgroundTaskIdentifier)
            self.backgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
        }
        
        isImageLoading = true
        error = nil
        isPresented = false
        
        Task {
            let result = await openai.variation(image: image, numberOfImages: noOfImages, resolution: resolution)
            DispatchQueue.main.async {
                if let imageArray = result.0 {
                    self.image = imageArray[0]
                    if let image = self.image {
                        self.imageArray.insert(image, at: 0)
                    }
                } else if let error = result.1 {
                    self.error = error
                    self.alertpresented = true
                }
                self.isImageLoading = false
                // End the background task when the API call is done
                UIApplication.shared.endBackgroundTask(self.backgroundTaskIdentifier)
                self.backgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
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
        if styleSelected != .noStyle {
            if let index = ImageStyle.data.firstIndex(where: { $0.style == styleSelected }) {
                let data = ImageStyle.data.remove(at: index)
                ImageStyle.data.insert(data, at: 1)
            }
        }
    }
}
