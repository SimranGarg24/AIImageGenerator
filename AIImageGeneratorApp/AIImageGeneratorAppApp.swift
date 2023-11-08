//
//  AIImageGeneratorAppApp.swift
//  AIImageGeneratorApp
//
//  Created by Saheem Hussain on 03/11/23.
//

import SwiftUI

@main
struct AIImageGeneratorAppApp: App {
    
    init() {
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .purple
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
