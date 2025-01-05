//
//  Home.swift
//  SP6
//
//  Created by Евгений Михайлов on 05.01.2025.
//

import SwiftUI

struct Home: View {
    @StateObject var model = HomeViewModel()
    @State var isNetworkError = false
    @State var ttt = "est"
    var body: some View {
        VStack{
            Text(ttt)
            HStack{
                
                Button(action: {
                    ttt = NetworkMonitor.shared.isConnected ? "connected" : "disconnected"
                    print(NetworkMonitor.shared.isConnected)}) {
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
                        ForEach(model.categories) { category in
                            Text(category.name)
                                .offset(x: 0, y: -3)
                                .foregroundColor(.text)
                                .font(.system(size: 12))
                                .frame(minWidth: 108, minHeight: 40)
                                .background(.block)
                                .cornerRadius(8)
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
                    Text("Все")
                        .font(.system(size: 12))
                        .foregroundColor(.accent)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                .padding(.top, 24)
                HStack(spacing: 15){
                    ForEach(model.sneakers) { sneaker in
                        if sneaker.bestseller {
                            ProductView(isLoading: model.isLoading, sneaker: sneaker)
                            ProductView(isLoading: model.isLoading, sneaker: sneaker)
                        }
                    }
                }
                .onLoading(isLoading: model.isLoading)
                .padding(.horizontal, 20)
                
            }
        }
        
        .onAppear {
            NetworkMonitor.shared.startMonitoring()
            load()
        }
        .alert("Ошибка", isPresented: $isNetworkError) {
            Button(action: {isNetworkError = false
                load()
            }) {
                Text("Попробовать снова")
            }
        } message: {
            Text("Проблема с подключением к интернету")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        
        
    }
    func load() {
        
        Task {
            do {
                try await model.fetchCategory()
                try await model.fetchSneakers()
            }
            catch {
                if let netWorkError = error as? URLError {
                    switch netWorkError.code {
                    case .notConnectedToInternet:
                        isNetworkError = true
                    case .cannotConnectToHost:
                        isNetworkError = true
                    case .networkConnectionLost:
                        isNetworkError = true
                    case .cannotFindHost:
                        isNetworkError = true
                    default:
                        print(error.localizedDescription)
                    }
                }
                print(error.localizedDescription)

            }

        }
    }
}

#Preview {
    Home()
}
