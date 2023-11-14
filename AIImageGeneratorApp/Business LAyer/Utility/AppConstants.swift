//
//  AppConstants.swift
//  AIImageGeneratorApp
//
//  Created by Saheem Hussain on 09/11/23.
//

import Foundation
import SwiftUI

struct AppConstants {
    static let aiImage = "Gen Art Pro"
    static let chooseStyle = "Choose Art Style"
    static let selectStyle = "Select Style"
    static let generated = "Generated Images"
    
    // Textfield placeholder
    static let placeholder = "eg., A mystical forest with moonlit fireflies or A bustling market with colorful stalls."
    
    // Alert messages
    static let deleteImageTitle = "Delete Image"
    static let deleteImageMssg = "You can't recover deleted images"
    static let imageSaved = "Image saved to photo album"
    static let errorSaving = "Error saving image. Please try again."
    static let enterprompt = "Please enter a valid prompt"
    static let wordLimitExceeded = "Word limit exceeded"
    static let internetConnection = "Your internet connection appears to be offline."
}

struct FirebaseKeys {
    static let apiKey = "ai_api_key"
}

struct ButtonLabels {
    static let seeAll = "See All"
    static let generate = "Generate Image"
    static let generateMore = "Generate More"
    static let okk = "OK"
    static let done = "Done"
    static let cancel = "Cancel"
    static let delete = "Delete"
    static let variate = "Variate"
}

struct AppColor {
    static let textColor = Color("TextColor")
    static let dividerColor = Color("DividerColor")
    static let orangeColor = Color("OrangeColor")
    static let grayBorderColor = Color("GrayBorderColor")
    static let lightGrayColor = Color("lightGrayColor")
}

struct AppImages {
    static let tick = "tick"
    static let backArrow = "backArrow"
    static let download = "downloadBtn"
    static let variate = "variate"
    static let bin = "bin"
    static let cross = "multiply.circle.fill"
}
