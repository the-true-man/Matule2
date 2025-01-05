//
//  ProductVIew.swift
//  SP6
//
//  Created by Евгений Михайлов on 05.01.2025.
//

import SwiftUI

struct ProductView: View {
    @State var isLoading = false
    var sneaker: Sneaker
    var body: some View {
        VStack(alignment: .leading){
            AsyncImage(url: sneaker.image!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
                .padding(.horizontal, 12)
                .padding(.top, 18)
            if sneaker.bestseller {
                Text("Best seller".uppercased())
                    .foregroundColor(.accent)
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
        .onLoading(isLoading: isLoading)
        .overlay(
            VStack {
                HStack {
                    Button(action: {}) {
                        ZStack {
                            Circle()
                                .foregroundColor(.background)
                            Image("heart")
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

#Preview {
    ProductView(sneaker: Sneaker(id: "qwe", name: "Nike Air Max", price: 752.0, category: 3, description: "qweqwe as asd", bestseller: true, fullname: "Nike Air Max qweqwe"))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
}
