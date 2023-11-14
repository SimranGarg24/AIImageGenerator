//
//  PhotoButtonView.swift
//  AIImageGeneratorApp
//
//  Created by Saheem Hussain on 09/11/23.
//

import SwiftUI

struct PhotoButtonView: View {
    
    @ObservedObject var contentvm: ContentViewModel
    
    @State private var isPresented = false
    var image: UIImage
    var index: Int
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            Image(uiImage: image)
                .resizable()
            
            if contentvm.imageArray.count > 1 {
                if image == contentvm.image {
                    Button {
                        isPresented = true
                    } label: {
                        Image(AppImages.bin)
                    }
                }
            }
            
        }
        .overlay(content: {
            RoundedRectangle(cornerRadius: 10)
                .stroke(image == contentvm.image ? AppColor.orangeColor : AppColor.lightGrayColor,
                        lineWidth: image == contentvm.image ? 3.5 : 1)
        })
        .frame(width: 70, height: 70)
        .cornerRadius(10)
        .alert(AppConstants.deleteImageTitle, isPresented: $isPresented, actions: {
            Button(ButtonLabels.cancel, role: .cancel) {}
            
            Button(ButtonLabels.delete, role: .destructive) {
                contentvm.imageArray.remove(at: index)
                if index == 0 {
                    contentvm.image = contentvm.imageArray[0]
                } else {
                    contentvm.image = contentvm.imageArray[index - 1]
                }
            }
        }, message: {
            Text(AppConstants.deleteImageMssg)
        })
    }
}

struct PhotoButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoButtonView(contentvm: ContentViewModel(), image: UIImage(named: "cartoon") ?? UIImage(), index: 0)
    }
}
