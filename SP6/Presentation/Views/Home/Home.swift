//
//  Home.swift
//  SP6
//
//  Created by Евгений Михайлов on 05.01.2025.
//

import SwiftUI
import SwiftSVG
@available(iOS 15.0, *)
struct Home: View {
    @State var navigationStack: [Tabs] = [.home]
    @StateObject var model = HomeViewModel()
    var body: some View {
        NavigationStack {
            ZStack{
                currentView()
                VStack{
                    Spacer()
                    ZStack(alignment: .leading){
                        Image("navbar")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .shadow(color: .subTextLight.opacity(0.4), radius: 10, x: 0, y: -3)
                        HStack{
                            Button(action: {navigationStack = [.home]}) {
                                Image(navigationStack.last == .home ? "home2" : "home")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 22, height: 24)
                            }
                            Spacer()
                            Button(action: {navigationStack.append(.favorites)}){
                                Image(navigationStack.last == .favorites ? "favorite select" : "favorite")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 22, height: 24)
                            }
                            Spacer()
                            
                            Button(action: {}) {
                                
                                ZStack{
                                    Circle()
                                        .frame(width: 56)
                                        .foregroundColor(.accent)
                                    Image("navbag2")
                                }
                            }
                            .offset(x: 0, y: -35)
                            .shadow(color: .accent.opacity(0.6), radius: 10, x: 0, y: 6)
                            Spacer()
                            
                            Button(action: {}) {
                                Image("notice")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 22, height: 24)
                            }
                            Spacer()
                            
                            Button(action: {}) {
                                
                                Image("user")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 22, height: 24)
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 30)
                    }
                }
            }.ignoresSafeArea(.all)
        }
    }
    @ViewBuilder
    func currentView() -> some View {
        let currentView = navigationStack.last ?? .home
        
        switch currentView {
        case .home:
            MainHomeView(model: model, navigationStack: $navigationStack)
        case .favorites:
            FavoriteView(navigationStack: $navigationStack, model: model)
        case .cart:
            EmptyView()
        case .notifications:
            EmptyView()
        case .profile:
            EmptyView()
        }
    
    }
}

#Preview {
    if #available(iOS 15.0, *) {
        Home()
    }
}
