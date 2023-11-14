//
//  LoaderView.swift
//  AIImageGeneratorApp
//
//  Created by Saheem Hussain on 03/11/23.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        VStack {
            
            HStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: AppColor.orangeColor))
                    .scaleEffect(2)
            }
            .padding(32)
            .background(Color.white)
            .cornerRadius(12)
        }
        .toolbar(.hidden, for: .tabBar)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black.opacity(0.8))
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
