//
//  StyleListView.swift
//  AIImageGeneratorApp
//
//  Created by Saheem Hussain on 03/11/23.
//

import SwiftUI

struct StyleListView: View {
    @Environment (\.dismiss) var dismiss
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        
        VStack {
            
            HeaderView(title: AppConstants.selectStyle)
                .padding(.vertical)
                .padding(.top)
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: viewModel.columns, spacing: 16) {
                    ForEach(ImageStyle.data, id: \.style) { data in
                        
                        Button {
                            viewModel.styleSelected = data.style
                            viewModel.sortImageStyles()
                            dismiss()
                        } label: {
                            StyleView(imageStyle: data, styleSelected: viewModel.styleSelected)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct StyleListView_Previews: PreviewProvider {
    static var previews: some View {
        StyleListView(viewModel: ContentViewModel())
    }
}
