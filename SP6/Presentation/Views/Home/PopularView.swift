//
//  PopularView.swift
//  SP6
//
//  Created by Евгений Михайлов on 06.01.2025.
//

import SwiftUI

struct PopularView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var model: HomeViewModel
    var body: some View {
        VStack{
            Spacer()
                .frame(maxHeight: 48)
            HStack{
                Button(action: {presentationMode.wrappedValue.dismiss()}) {
                    ZStack{
                        Circle()
                            .foregroundColor(.block)
                        Image("leftstr")

                    }
                }
                Spacer()
                Text("Популярное")
                    .foregroundColor(.text)
                    .font(.system(size: 16))
                Spacer()
                Button(action: {}) {
                    ZStack{
                        Circle()
                            .foregroundColor(.block)
                        Image("heart")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)

                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 44)
            Spacer()
                .frame(maxHeight: 20)
            if #available(iOS 16.0, *) {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible(minimum: 100, maximum: .infinity), spacing: 15),GridItem(.flexible(minimum: 100, maximum: .infinity), spacing: 15)], spacing: 15) {
                        ForEach(0..<8) { _ in
                            ForEach(model.sneakers) { sneaker in
                                if sneaker.bestseller {
                                    ProductView(isLoading: model.isLoading, sneaker: sneaker)
                                }                            }
                        }
                    }
                    .onLoading(isLoading: model.isLoading)
                    Spacer()
                        .frame(height: 48)
                }
                
                .scrollIndicators(.hidden)
            }

        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .ignoresSafeArea(.all)
        
    }
}

