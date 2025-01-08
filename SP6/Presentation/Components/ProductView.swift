//
//  ProductVIew.swift
//  SP6
//
//  Created by Евгений Михайлов on 05.01.2025.
//

import SwiftUI

@available(iOS 15.0, *)
struct ProductView: View {
    @StateObject var model: HomeViewModel
    @State var isLoading = false
    var sneaker: Sneaker
    var body: some View {
        VStack(alignment: .leading){
            AsyncImage(url: sneaker.image!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                HStack{
                    Spacer()
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                .frame(width: 100, height: 60)
            }
                .padding(.horizontal, 12)
                .padding(.top, 18)
            if sneaker.bestseller {
                Text("Best seller".uppercased())
                    .foregroundColor(.accent)
                    .font(.system(size: 12))
                    .padding(.bottom, 8)
            }
            else {
                Text("")
                    .font(.system(size: 12))
                    .padding(.bottom, 8)
            }
            Text(sneaker.name)
                .foregroundColor(.hint)
                .font(.system(size: 16))
                .padding(.bottom, 4)
            HStack {
                Text("₽\(sneaker.price)")
                    .foregroundColor(.text)
                    .font(.system(size: 14))
                Spacer()
                Button(action: {}) {
                    ZStack{
                        Rectangle()
                            .frame(width: 34, height: 34)
                            .foregroundColor(.accent)
                            .clipShape(RoundedCorner(radius: 16, corners: [.topLeft, .bottomRight]))
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
            }
            
        }
        .frame(maxHeight: 190)
        .onLoading(isLoading: isLoading)
        .overlay(
            VStack {
                HStack {
                    Button(action: {model.addAndDeleteToFavorite(selectSneaker: sneaker)}) {
                        ZStack {
                            Circle()
                                .foregroundColor(.background)
                            Image(model.favorites.contains(where: { $0.id == sneaker.id }) ? "favorite fill" : "heart")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16, height: 16)

                        }
                        .frame(width: 29, height: 28)

                    }
                    .padding(.top, 9)
                    Spacer()
                }
                Spacer()
            }
            
        )
        .padding(.leading, 9)
        .background(Color.block)
        .cornerRadius(16)
        
    }
}

