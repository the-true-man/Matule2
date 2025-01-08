//
//  CategoryCatalogVie.swift
//  SP6
//
//  Created by Евгений Михайлов on 06.01.2025.
//

import SwiftUI

struct CategoryCatalogView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var model: HomeViewModel
    @State var selectedCategory: Category
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                    .frame(height: 48)
                HStack{
                    Button(action: {presentationMode.wrappedValue.dismiss()
                        model.selectedCategory = -1}) {
                            Image("leftstr")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 44, height: 44)
                        }
                    Spacer()
                    Text(selectedCategory.name)
                        .foregroundColor(.text)
                        .font(.system(size: 16))
                        .offset(x: 0, y: -4)
                    Spacer()
                    Spacer()
                        .frame(width: 44)
                }
                .padding(.horizontal, 20)
                Spacer()
                    .frame(height: 16)
                Text("Категории")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                    .font(.system(size: 16))
                    .foregroundColor(.text)
                if #available(iOS 16.0, *) {
                    ScrollView(.horizontal) {
                        HStack(spacing: 16){
                            Spacer()
                                .frame(width: 4)
                            ForEach(model.categories.indices, id: \.self) { index in
                                Button(action:{
                                    model.selectedCategory = index
                                    selectedCategory = model.categories[index]
                                }){
                                    Text(model.categories[index].name)
                                        .offset(x: 0, y: -3)
                                        .font(.system(size: 12))
                                        .foregroundColor(model.selectedCategory == model.categories[index].id ? Color.block : Color.text)
                                        .frame(minWidth: 108, minHeight: 40)
                                        .background(model.selectedCategory == model.categories[index].id  ? Color.accent : Color.block)
                                        .cornerRadius(8)
                                }
                            }
                            Spacer()
                                .frame(width: 4)
                        }
                    }
                    .onLoading(isLoading: model.isLoading)
                    .scrollIndicators(.hidden)
                }
                Spacer()
                    .frame(height: 20)
                if #available(iOS 16.0, *) {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible(minimum: 100, maximum: .infinity), spacing: 15),GridItem(.flexible(minimum: 100, maximum: .infinity), spacing: 15)], spacing: 15) {
                            ForEach(model.sneakers) { sneaker in
                                if sneaker.category == selectedCategory.id && selectedCategory.id != 0 {
                                    
                                    ProductView(model: model ,isLoading: model.isLoading, sneaker: sneaker)
                                }
                                if(selectedCategory.id == 0) {
                                    ProductView(model: model ,isLoading: model.isLoading, sneaker: sneaker)
                                }
                                
                            }
                            
                        }
                        .onLoading(isLoading: model.isLoading)
                        Spacer()
                            .frame(height: 48)
                    }
                    .padding(.horizontal, 20)
                    .scrollIndicators(.hidden)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
            .background(Color.background)
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    CategoryCatalogView(model: HomeViewModel(), selectedCategory: Category(id: 2, name: "Outdoor"))
}
