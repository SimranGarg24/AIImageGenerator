//
//  ResponseView.swift
//  AIImageGeneratorApp
//
//  Created by Saheem Hussain on 03/11/23.
//

import SwiftUI

struct ResponseView: View {
    
    @Environment (\.dismiss) var dismiss
    @ObservedObject var contentVm: ContentViewModel
    @StateObject var responseVm = ResponseViewModel()
    
    var body: some View {
        
        if let image = contentVm.image {
            
            ZStack {
                
                VStack(spacing: 20) {
                    
                    HeaderView(title: AppConstants.generated, leftBtnImage: AppImages.backArrow, leftBtnAction: {
                        dismiss()
                    }, rightBtnImage: AppImages.download, rightBtnAction: {
                        responseVm.saveImage(image: image)
                    })
                    .padding(.top, 4)
                    
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<contentVm.imageArray.count, id: \.self) { ind in
                                Button {
                                    contentVm.image = contentVm.imageArray[ind]
                                } label: {
                                    PhotoButtonView(contentvm: contentVm, image: contentVm.imageArray[ind], index: ind)
                                }
                            }
                        }
                        
                    }
                    .padding(.horizontal, 20)
                    
                    HStack(spacing: 20) {
                        
                        ButtonView(title: ButtonLabels.variate) {
                            contentVm.variation(image: image)
                        }
                        
                        ButtonView(title: ButtonLabels.generate, action: {
                            if !contentVm.text.trimmingCharacters(in: .whitespaces).isEmpty {
                                contentVm.generateImage()
                            }
                        })
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    Spacer()
                }
                
                if contentVm.isImageLoading {
                    LoaderView()
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                contentVm.onResponseScreen = true
            }
            .alert(contentVm.error ?? String(), isPresented: $contentVm.alertpresented) {
                Button(ButtonLabels.okk, role: .cancel) { }
            }
            .alert(responseVm.message, isPresented: $responseVm.presenAlert) {
                Button(ButtonLabels.okk, role: .cancel) { }
            }
            .onDisappear {
                contentVm.onResponseScreen = false
                contentVm.imageArray = []
            }
        }
        
    }
}

struct ResponseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ResponseView(contentVm: ContentViewModel())
        }
    }
}
