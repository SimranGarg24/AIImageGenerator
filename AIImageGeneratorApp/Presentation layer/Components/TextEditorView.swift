//
//  TextEditorView.swift
//  AIImageGeneratorApp
//
//  Created by Saheem Hussain on 03/11/23.
//

import SwiftUI

struct TextEditorView: View {
    
    var title: String
    var textLimit: Int
    @Binding var text: String
//    @Binding var showToast: Bool
    @FocusState var isFocus: Bool
    
    var body: some View {
        
        VStack {
            
            ZStack(alignment: .topLeading) {
                
                TextEditor(text: $text)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        
                        Button(ButtonLabels.done) {
                            self.hideKeyboard()
                        }
                    }
                }
                .focused($isFocus)
                .padding([.top, .leading, .trailing], 8)
                
                if text.isEmpty {
                    Text(AppConstants.placeholder)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 12)
                        .padding(.top, 15)
                        .onTapGesture {
                            isFocus = true
                        }
                }
            }
            HStack {
                
                Spacer()
                
                if !text.isEmpty {
                    Text("\(text.count) / \(textLimit)")
                        .font(.system(size: 14))
                        .foregroundColor(text.count > textLimit ? .red : .gray)
                    
                    Button {
                        text = String()
                    } label: {
                        Image(systemName: AppImages.cross)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.black, .gray.opacity(0.3))
                            .font(.system(size: 26))
                    }
                }
            }
            .padding([.trailing, .bottom])
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(AppColor.grayBorderColor, lineWidth: 1)
        )
    }
}

struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView(title: AppConstants.placeholder, textLimit: 1000, text: Binding.constant(String()))
    }
}
