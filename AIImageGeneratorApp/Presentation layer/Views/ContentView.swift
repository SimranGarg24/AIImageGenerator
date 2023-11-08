//
//  ContentView.swift
//  AIImageGeneratorApp
//
//  Created by Saheem Hussain on 03/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    @FocusState var isFocus: Bool
    
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        Text("Turn Words into Art!!")
                            .font(.largeTitle)
                            .bold()
                            .padding(.top)
                        
                        Text("Enter Prompt")
                            .bold()
                            .padding(.top)
                        
                        TextEditorView(title: "What do you want to create?",
                                       textLimit: viewModel.textLimit,
                                       text: $viewModel.text)
                        
                        HStack(alignment: .bottom) {
                            Text("Choose Style")
                                .bold()
                            
                            Spacer()
                            
                            Button {
                                viewModel.presentStyleView()
                            } label: {
                                Text("See All")
                                    .font(.system(size: 15))
                                    .underline(pattern: .dot)
                            }
                            
                        }.padding(.top)
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            
                            ForEach(0..<6, id: \.self) { index in
                                
                                Button {
                                    viewModel.styleSelected = ImageStyle.data[index].style
                                } label: {
                                    StyleView(imageStyle: ImageStyle.data[index],
                                              styleSelected: viewModel.styleSelected)
                                }
                                
                            }
                        }
                        .padding(2)
                        .frame(maxHeight: 300)
                        
                        ButtonView(title: "Generate", action: {
                            viewModel.hideKeyboard()
                            viewModel.generateImage()
                        })
                        .padding(.vertical)
                        
                        Spacer()
                    }
                    .padding(20)
                }
                .onTapGesture {
                    viewModel.hideKeyboard()
                }
                
                if viewModel.isImageLoading {
                    LoaderView()
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .alert(viewModel.error ?? "", isPresented: $viewModel.isPresented) {
                Button("OK", role: .cancel) { }
            }
            .sheet(isPresented: $viewModel.presentStyleSheet) {
                StyleListView(viewModel: viewModel)
                    .presentationDetents([.medium, .large])
            }
            .navigationDestination(isPresented: $viewModel.nextScreen) {
                ResponseView(contentVm: viewModel)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
