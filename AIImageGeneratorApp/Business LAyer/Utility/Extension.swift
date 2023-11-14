//
//  Extension.swift
//  AIImageGeneratorApp
//
//  Created by Saheem Hussain on 09/11/23.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
