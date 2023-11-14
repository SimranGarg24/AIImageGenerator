//
//  ButtonView.swift
//  AIImageGeneratorApp
//
//  Created by Saheem Hussain on 03/11/23.
//

import SwiftUI

struct ButtonView: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        
        Button {
            action()
        } label: {
            Text(title)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .padding(.vertical)
        }
        .frame(maxWidth: .infinity)
        .background(AppColor.orangeColor)
        .cornerRadius(10)
        
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: ButtonLabels.generate, action: {})
    }
}
