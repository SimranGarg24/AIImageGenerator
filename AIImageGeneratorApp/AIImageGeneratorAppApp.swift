//
//  AIImageGeneratorAppApp.swift
//  AIImageGeneratorApp
//
//  Created by Saheem Hussain on 03/11/23.
//

import SwiftUI
import Firebase

@main
struct AIImageGeneratorAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        FirebaseRemoteConfig.shared.setUpRemoteConfig()
        FirebaseRemoteConfig.shared.setupRemoteConfigDefaults()
        FirebaseRemoteConfig.shared.fetchRemoteConfig()
        
        // to increase time of launch screen
        Thread.sleep(forTimeInterval: 4.0)

        return true
    }
}
