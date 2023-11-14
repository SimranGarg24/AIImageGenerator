//
//  FirebaseRemoteConfig.swift
//  AIImageGeneratorApp
//
//  Created by Saheem Hussain on 10/11/23.
//

import Foundation
import FirebaseRemoteConfig

class FirebaseRemoteConfig {
    
    static let shared = FirebaseRemoteConfig()
    var remoteConfig = RemoteConfig.remoteConfig()
    private init() {}
    
    func setUpRemoteConfig() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }
    
    // You can set in-app default parameter values in the Remote Config object, so that your app behaves
    // as intended before it connects to the Remote Config backend,
    // and so that default values are available if none are set in the backend.
    // Define a set of parameter names, and default parameter values using an NSDictionary object or a plist file.
    func setupRemoteConfigDefaults() {
        let defaultValue = [FirebaseKeys.apiKey: "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" as NSObject]
        remoteConfig.setDefaults(defaultValue)
        OpenAIKitManager.shared.setup()

    }
    
    // fetch values from firebase
    func fetchRemoteConfig() {
        remoteConfig.fetch { (_, error) in
            guard error == nil else {return}
            print("Got the value from Remote Config!")
            self.remoteConfig.activate()
            print("fetch: ", self.remoteConfig.configValue(forKey: FirebaseKeys.apiKey).stringValue ?? "")
            OpenAIKitManager.shared.setup()
        }
    }
    
    func getAPIKey() -> String {
        let apiKey = remoteConfig.configValue(forKey: FirebaseKeys.apiKey).stringValue
        print(apiKey ?? "")
        return apiKey ?? ""
    }
    
}
