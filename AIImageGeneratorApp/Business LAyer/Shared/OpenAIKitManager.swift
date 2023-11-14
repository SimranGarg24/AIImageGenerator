//
//  OpenAIKitManager.swift
//  AIImageGeneratorApp
//
//  Created by Saheem Hussain on 03/11/23.
//

import Foundation
import SwiftUI
import OpenAIKit

class OpenAIKitManager {
    
    var openai: OpenAI?
    
    static let shared = OpenAIKitManager()
    private init() {}
    
    func setup() {
        openai = OpenAI(Configuration(organization: "Personal", apiKey: FirebaseRemoteConfig.shared.getAPIKey()))
    }
    
    func generateImage(promt: String, resolution: ImageResolutions,
                       numberOfImages: Int) async -> ([UIImage]?, String?) {
        
        do {
            let params = ImageParameters(prompt: promt, numberofImages: numberOfImages,
                                         resolution: .medium, responseFormat: .base64Json)
            
            guard let openai = openai else {
                return (nil, "Open AI is not initialized")
            }
            
            let result = try await openai.createImage(parameters: params)
            
            var imageArray: [UIImage] = []
            
            for data in result.data {
                let image = try openai.decodeBase64Image(data.image)
                imageArray.append(image)
            }
            return (imageArray, nil)
            
        } catch {
            print(String(describing: error))
            if let error = error as? OpenAIErrorResponse {
                return (nil, error.error.message)
            }
            if error.localizedDescription == "The Internet connection appears to be offline." {
                return (nil, AppConstants.internetConnection)
            }
            return (nil, error.localizedDescription)
        }
        
    }
    
    func generateImageUrl(promt: String, resolution: ImageResolutions,
                          numberOfImages: Int) async -> ([String]?, String?) {
        
        do {
            let params = ImageParameters(prompt: promt, numberofImages: numberOfImages,
                                         resolution: resolution, responseFormat: .url)
            guard let openai = openai else {
                return (nil, nil)
            }
            let result = try await openai.createImage(parameters: params)
            var imageUrlArray: [String] = []
            
            for data in result.data {
                imageUrlArray.append(data.image)
            }
            return (imageUrlArray, nil)
        } catch {
            print(String(describing: error))
            if let error = error as? OpenAIErrorResponse {
                return (nil, error.error.message)
            }
            if error.localizedDescription == "The Internet connection appears to be offline." {
                return (nil, AppConstants.internetConnection)
            }
            return (nil, error.localizedDescription)
        }
    }
    
    func editImage(image: UIImage, mask: UIImage, prompt: String, numberOfImages: Int,
                   resolution: ImageResolutions) async -> ([UIImage]?, String?) {
        
        do {
            let params = try ImageEditParameters(image: image, mask: mask, prompt: prompt,
                                                 numberOfImages: numberOfImages, resolution: resolution,
                                                 responseFormat: .base64Json)
            guard let openai = openai else {
                return (nil, nil)
            }
            let result = try await openai.generateImageEdits(parameters: params)
            var imageArray: [UIImage] = []
            
            for data in result.data {
                let image = try openai.decodeBase64Image(data.image)
                imageArray.append(image)
            }
            return (imageArray, nil)
        } catch {
            print(String(describing: error))
            if let error = error as? OpenAIErrorResponse {
                return (nil, error.error.message)
            }
            if error.localizedDescription == "The Internet connection appears to be offline." {
                return (nil, AppConstants.internetConnection)
            }
            return (nil, error.localizedDescription)
        }
    }
    
    func editImageUrl(image: UIImage, mask: UIImage, prompt: String, numberOfImages: Int,
                      resolution: ImageResolutions) async -> ([String]?, String?) {
        
        do {
            let params = try ImageEditParameters(image: image, mask: mask, prompt: prompt,
                                                 numberOfImages: numberOfImages, resolution: resolution,
                                                 responseFormat: .url)
            guard let openai = openai else {
                return (nil, nil)
            }
            let result = try await openai.generateImageEdits(parameters: params)
            var imageUrlArray: [String] = []
            
            for data in result.data {
                imageUrlArray.append(data.image)
            }
            return (imageUrlArray, nil)
        } catch {
            print(String(describing: error))
            if let error = error as? OpenAIErrorResponse {
                return (nil, error.error.message)
            }
            if error.localizedDescription == "The Internet connection appears to be offline." {
                return (nil, AppConstants.internetConnection)
            }
            return (nil, error.localizedDescription)
        }
    }
    
    func variation(image: UIImage, numberOfImages: Int,
                   resolution: ImageResolutions) async -> ([UIImage]?, String?) {
        
        do {
            let params = try ImageVariationParameters(image: image, numberOfImages: numberOfImages,
                                                      resolution: resolution, responseFormat: .base64Json)
            guard let openai = openai else {
                return (nil, nil)
            }
            let result = try await openai.generateImageVariations(parameters: params)
            
            var imageArray: [UIImage] = []
            
            for data in result.data {
                let image = try openai.decodeBase64Image(data.image)
                imageArray.append(image)
            }
            return (imageArray, nil)
            
        } catch {
            print(error.localizedDescription)
            if let error = error as? OpenAIErrorResponse {
                return (nil, error.error.message)
            }
            if error.localizedDescription == "The Internet connection appears to be offline." {
                return (nil, AppConstants.internetConnection)
            }
            return (nil, error.localizedDescription)
        }
    }

}
