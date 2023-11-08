//
//  ResultView.swift
//  AIImageGeneratorApp
//
//  Created by Saheem Hussain on 03/11/23.
//

import SwiftUI

struct ResultView: View {
    
    @StateObject var resultVm = ResultViewModel()
    
    var image: UIImage
    
    var body: some View {
        
        VStack {
            
            ZStack(alignment: .topTrailing) {
                
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
                
                Button {
                    resultVm.saveImage(image: image)
                } label: {
                    Image(systemName: "arrow.down.app.fill")
                        .font(.title)
                        .foregroundColor(.white)
                }
                .disabled(resultVm.isSaving)
            }
            
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 20) {
//                    ForEach(resultVm.imageArray, id: \.self) { image in
//
//                        Button {
//                        } label: {
//                            Image(uiImage: image)
//                                .resizable()
//                                .scaledToFit()
//                        }
//                        .frame(width: 100, height: 100)
//                        .cornerRadius(12)
//                        .onAppear {
//                            print("\(image)")
//                        }
//                    }
//                }
//                .padding(2)
//
//            }
//            .padding(.vertical, 12)
            
        }
        .padding()
        
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(image: UIImage(named: "cartoon") ?? UIImage())
    }
}
