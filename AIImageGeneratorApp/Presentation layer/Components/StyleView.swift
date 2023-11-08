//
//  StyleView.swift
//  AIImageGeneratorApp
//
//  Created by Saheem Hussain on 03/11/23.
//

import SwiftUI

struct StyleView: View {
    var imageStyle: ImageStyle
    var styleSelected: Style
    
    var body: some View {
        
        VStack {
            
            Image(imageStyle.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .cornerRadius(12)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.purple, lineWidth: styleSelected == imageStyle.style ? 5 : 1)
                }
                .padding(1)
            
            Text(imageStyle.style.rawValue)
                .font(.subheadline)
                .foregroundColor(.black)
        }
        
    }
}

struct StyleView_Previews: PreviewProvider {
    static var previews: some View {
        StyleView(imageStyle: ImageStyle.data[0], styleSelected: .noStyle)
    }
}
