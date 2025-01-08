//
//  MainHomeView.swift
//  SP6
//
//  Created by Евгений Михайлов on 08.01.2025.
//

import SwiftUI

struct MainHomeView: View {
    @StateObject var model: HomeViewModel
    @Binding var navigationStack: [Tabs]
    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    Spacer()
                        .frame(height: 43)
                    HStack{
                        Button(action: {}) {
                            Image("hamb")
                        }
                        .offset(x: 0, y: 4)
                        Spacer()
                        Text("Главная")
                            .font(.system(size: 32))
                            .foregroundColor(.text)
                            .overlay {
                                Image("tilemain")
                                    .frame(maxWidth: .infinity, maxHeight:  .infinity, alignment: .topLeading)
                                    .offset(x: -14, y: -4)
                            }
                        Spacer()
                        Button(action: {}) {
                            Image("bag2")
                        }
                        .frame(maxHeight: .infinity, alignment: .bottom)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 49)
                    .padding(.horizontal, 20)
                    Spacer()
                        .frame(height: 26)
                    HStack(spacing: 14){
                        Button(action: {}) {
                            HStack(spacing: 12){
                                Image("search")
                                    .padding(.leading, 26)
                                Text("Поиск")
                                    .font(.system(size: 12))
                                    .foregroundColor(.hint)
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, maxHeight: 52)
                            .background(.block)
                            .cornerRadius(14)
                        }
                        .shadow(color: Color.subTextLight.opacity(0.4), radius: 4, x: 0, y: 5)
                        .buttonStyle(.plain)
                        
                        Button(action: {}) {
                            ZStack{
                                Circle()
                                    .foregroundColor(.accent)
                                    .frame(width: 52, height: 52)
                                Image("sliders")
                            }
                        }
                        .shadow(color: Color.subTextLight.opacity(0.7), radius: 4, x: 0, y: 5)
                    }
                    .padding(.horizontal, 20)
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
                                    
                                    NavigationLink(destination: CategoryCatalogView(model: model, selectedCategory: model.categories[index]).navigationBarBackButtonHidden(true)) {
                                        Text(model.categories[index].name)
                                            .offset(x: 0, y: -3)
                                            .font(.system(size: 12))
                                            .foregroundColor(model.selectedCategory == model.categories[index].id ? Color.block : Color.text)
                                            .frame(minWidth: 108, minHeight: 40)
                                            .background(model.selectedCategory == model.categories[index].id ? Color.accent : Color.block)
                                            .cornerRadius(8)
                                    }
                                    .simultaneousGesture(TapGesture().onEnded {
                                        model.selectedCategory = model.categories[index].id
                                    })
                                }
                                Spacer()
                                    .frame(width: 4)
                            }
                        }
                        .onLoading(isLoading: model.isLoading)
                        .scrollIndicators(.hidden)
                        HStack{
                            Text("Популярное")
                                .font(.system(size: 16))
                                .foregroundColor(.text)
                            Spacer()
                            NavigationLink(destination: PopularView(model: model) .navigationBarBackButtonHidden(true)) {
                                Text("Все")
                                    .font(.system(size: 12))
                                    .foregroundColor(.accent)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
                        .padding(.top, 24)
                        HStack(spacing: 15){
                            ForEach(model.sneakers) { sneaker in
                                if sneaker.bestseller {
                                    ProductView(model: model ,isLoading: model.isLoading, sneaker: sneaker)
                                    ProductView(model: model ,isLoading: model.isLoading, sneaker: sneaker)
                                }
                            }
                        }
                        .onLoading(isLoading: model.isLoading)
                        .padding(.horizontal, 20)
                        Text("Акции")
                            .font(.system(size: 16))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.text)
                            .padding(.top, 29)
                            .padding(.bottom, 20)
                            .padding(.horizontal, 20)
                        AsyncImage(url: model.ads) {image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(.horizontal, 20)
                        } placeholder: {
                            ProgressView()
                        }
                        Spacer()
                            .frame(height: 150)
                        
                    }
                }
                
                .alert("Ошибка", isPresented: $model.isNetworkError) {
                    Button(action: {
                        model.fetchData()
                    }) {
                        Text("Попробовать снова")
                    }
                } message: {
                    Text("Проблема с подключением к интернету")
                }
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.background)
                .ignoresSafeArea(.all)
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    MainHomeView(model: HomeViewModel(), navigationStack: .constant([.home]))
}
