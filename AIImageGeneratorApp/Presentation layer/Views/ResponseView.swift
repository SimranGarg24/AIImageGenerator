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
    
    var body: some View {
        
        if let image = contentVm.image {
            
            ZStack {
                VStack {
                    
                    ResultView(image: image)
                    
                    HStack {
                        
                        ButtonView(title: "Variate", action: {
//                            if !contentVm.text.trimmingCharacters(in: .whitespaces).isEmpty {
                                contentVm.variation(image: image)
//                            }
                        })
                        
                        ButtonView(title: "Regenerate", action: {
                            if !contentVm.text.trimmingCharacters(in: .whitespaces).isEmpty {
                                contentVm.generateImage()
                            }
                        })
                    }
                    .padding()
                    .padding(.top, 20)
                    
                    Spacer()
                }
                
                if contentVm.isImageLoading {
                    LoaderView()
                }
            }
            .navigationTitle("Result")
            .navigationBarTitleDisplayMode(.inline)
            .alert(contentVm.error ?? "", isPresented: $contentVm.isPresented) {
                Button("OK", role: .cancel) { }
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
