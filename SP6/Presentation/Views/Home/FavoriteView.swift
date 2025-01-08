//
//  FavoriteView.swift
//  SP6
//
//  Created by Евгений Михайлов on 07.01.2025.
//

import SwiftUI

struct FavoriteView: View {
    @Binding var navigationStack: [Tabs]
    @StateObject var model: HomeViewModel
    var body: some View {
        VStack{
            Spacer()
                .frame(height: 48)
            HStack{
                Button(action: {navigationStack.removeLast()}) {
                    ZStack{
                        Circle()
                            .foregroundColor(.block)
                            .frame(height: 44)

                        Image("leftstr")
                    }
                }
                Spacer()
                Text("Избранное")
                    .foregroundColor(.text)
                    .font(.system(size: 16))
                Spacer()
                Button(action: {}) {
                    ZStack{
                        Circle()
                            .foregroundColor(.block)
                            .frame(height: 44)

                        Image("favorite fill")
                    }
                }
            }
            .padding(.leading, 21)
            .padding(.bottom, 20)
            .padding(.trailing, 15)
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible(minimum: 100, maximum: 200), spacing: 15), GridItem(.flexible(minimum: 100, maximum: 200), spacing: 15)], spacing: 15) {
                    
                    ForEach(model.favorites) { favorite in
                        ProductView(model: model ,isLoading: model.isLoading, sneaker: favorite)
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .background(Color.background)
    }
}

#Preview {
    FavoriteView(navigationStack: .constant([.home]), model: HomeViewModel())
}
