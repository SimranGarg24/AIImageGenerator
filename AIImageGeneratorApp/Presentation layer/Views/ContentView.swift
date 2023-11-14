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
    
    var body: some View {
        
        NavigationStack {
            GeometryReader { _ in
                
                ZStack {
                    
                    VStack {
                        HeaderView(title: AppConstants.aiImage)
                            .padding(.top, 4)
                        
                        VStack(spacing: 4) {
                            TextEditorView(title: AppConstants.placeholder,
                                           textLimit: viewModel.textLimit,
                                           text: $viewModel.text
                            )
                            .frame(minHeight: 150, maxHeight: 170)
                            .padding(.top, 12)
                            
                            HStack {
                                Text(AppConstants.chooseStyle)
                                    .font(.system(size: 19))
                                    .foregroundColor(AppColor.textColor)
                                    .bold()
                                
                                Spacer()
                                
                                Button {
                                    viewModel.presentStyleView()
                                } label: {
                                    Text(ButtonLabels.seeAll)
                                        .font(.system(size: 13))
                                        .foregroundColor(AppColor.textColor.opacity(0.5))
                                }
                            }
                            .padding(.top, 20)
                            
                            LazyVGrid(columns: viewModel.columns, spacing: 16) {
                                
                                ForEach(0..<6, id: \.self) { index in
                                    
                                    Button {
                                        viewModel.styleSelected = ImageStyle.data[index].style
                                    } label: {
                                        StyleView(imageStyle: ImageStyle.data[index],
                                                  styleSelected: viewModel.styleSelected)
                                    }
                                    
                                }
                            }
                            .padding(.top, 8)
                            
                            Spacer()
                            
                            ButtonView(title: ButtonLabels.generate, action: {
                                self.hideKeyboard()
                                viewModel.generateImage()
                            })
                            .frame(width: 200)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                    }
                    .ignoresSafeArea(.keyboard, edges: .all)
                    
                    if viewModel.isImageLoading {
                        LoaderView()
                    }
                }
            }
            .ignoresSafeArea(.keyboard)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .alert(viewModel.error ?? String(), isPresented: $viewModel.isPresented) {
                Button(ButtonLabels.okk, role: .cancel) { }
            }
            .sheet(isPresented: $viewModel.presentStyleSheet) {
                StyleListView(viewModel: viewModel)
                    .presentationDetents([.large])
            }
            .navigationDestination(isPresented: $viewModel.nextScreen) {
                ResponseView(contentVm: viewModel)
            }
            .alert(AppConstants.wordLimitExceeded, isPresented: $viewModel.showToast) {
                Button(ButtonLabels.okk, role: .cancel) { }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView()
        }
    }
}
