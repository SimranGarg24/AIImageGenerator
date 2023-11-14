//
//  HeaderView.swift
//  AIImageGeneratorApp
//
//  Created by Saheem Hussain on 09/11/23.
//

import SwiftUI

struct HeaderView: View {
    
    var title: String
    
    var leftBtnImage: String?
    var leftBtnAction: (() -> Void)?
    
    var rightBtnImage: String?
    var rightBtnAction: (() -> Void)?
    
    var body: some View {
        
        VStack {
            HStack {
                if let leftBtnImage, let leftBtnAction {
                    Button {
                        leftBtnAction()
                    } label: {
                        Image(leftBtnImage)
                    }
                    .padding(.leading, 20)
                }
                
                Spacer()
                
                Text(title)
                    .font(.system(size: 17))
                    .foregroundColor(AppColor.textColor)
                    .bold()
                    
                Spacer()
                
                if let rightBtnImage, let rightBtnAction {
                    Button {
                        rightBtnAction()
                    } label: {
                        Image(rightBtnImage)
                    }
                    .padding(.trailing, 20)
                }

            }
            
            Rectangle()
                .frame(height: 1.5)
                .foregroundColor(AppColor.dividerColor)
                .padding(.top, 4)
        }
        
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: AppConstants.aiImage)
    }
}
