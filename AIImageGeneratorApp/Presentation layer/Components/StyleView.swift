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
            
            ZStack {
                
                Image(imageStyle.image)
                    .resizable()
                    .cornerRadius(7)
                
                ZStack(alignment: .topTrailing) {
                    
                    RoundedRectangle(cornerRadius: 7)
                        .fill(LinearGradient(gradient: Gradient(colors: [.black.opacity(0), .black.opacity(0.4)]),
                                             startPoint: .top,
                                             endPoint: .bottom))
                    
                    if styleSelected == imageStyle.style {
                        Image(AppImages.tick)
                            .offset(CGSize(width: 0, height: -0.3))
                    }
                }
                
                VStack {
                    
                    Spacer()
                    
                    Text(imageStyle.style.rawValue)
                        .font(.system(size: 13))
                        .bold()
                        .foregroundColor(.white)
                        .padding(.bottom)
                        .padding(.horizontal, 4)
                }
            }
            .overlay {
                RoundedRectangle(cornerRadius: 7)
                    .stroke(styleSelected == imageStyle.style ? AppColor.orangeColor : AppColor.grayBorderColor,
                            lineWidth: styleSelected == imageStyle.style ? 2.5 : 1)
            }
            .frame(minHeight: 120, maxHeight: 135)
    }
}

struct StyleView_Previews: PreviewProvider {
    static var previews: some View {
        StyleView(imageStyle: ImageStyle.data[1], styleSelected: .oilPaint)
    }
}
