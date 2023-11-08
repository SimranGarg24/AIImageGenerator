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
    
    var body: some View {
        
        VStack {
            
            TextField(title, text: $text, axis: .vertical)
                .tint(.purple)
                .padding(.bottom, 20)
                .onChange(of: text) { _ in
                    if text.count > textLimit {
                        text = String(text.prefix(textLimit))
                    }
                }
            
            HStack {
                
                Spacer()
                
                if !text.isEmpty {
                    Text("\(text.count) / \(textLimit)")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    Button {
                        text = String()
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.black, .gray.opacity(0.3))
                            .font(.system(size: 26))
                    }
                }
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.purple, lineWidth: 1)
        )
        .padding(.horizontal, 1)
    }
}

struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView(title: "Type Something..", textLimit: 200, text: Binding.constant(String()))
    }
}
