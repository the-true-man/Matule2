//
//  Onboards.swift
//  SP6
//
//  Created by Евгений Михайлов on 05.01.2025.
//

import SwiftUI

@available(iOS 15.0, *)
struct Onboarding: View {
    @AppStorage("isNavigateToMain") var isNavigate = false
    @AppStorage("currentOnboard") var currentOnboard = 0
    var body: some View {
        NavigationStack {
            VStack{
                Spacer()
                    .frame(height: currentOnboard == 0 ? 70 : 80)
                switch currentOnboard {
                case 0: Onboard_1()
                case 1: Onboard_2()
                case 2: Onboard_3()
                default: Onboard_1()
                }
                CapsulePages(currentPages: $currentOnboard)
                Spacer()
                Button(action: {nextOnboard()}) {
                    Text(currentOnboard == 0 ? "Начать" : "Далее")
                        .font(.system(size: 14))
                        .foregroundColor(.text)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(.block)
                        .cornerRadius(13)
                }
                .padding(.horizontal, 20)
                Spacer()
                    .frame(height: 36)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
            .background(LinearGradient(colors: [Color.accent, Color.disable], startPoint: .top, endPoint: .bottom))
            .animation(.spring(duration: 0.65), value: currentOnboard)
            .gesture(DragGesture().onEnded { value in
                if(value.translation.width > 50) {
                    nextOnboard(increment: -1)
                }
                else {
                    nextOnboard(increment: 1)
                }
            })
            .navigationDestination(isPresented: $isNavigate, destination: {
                Home()
                    .navigationBarBackButtonHidden(true)
            })
        }
        .navigationViewStyle(.stack)
        
    }
    func nextOnboard(increment: Int = 1) {
        if increment == 1 {
            if currentOnboard + increment == 3 {
                isNavigate = true
            }
            currentOnboard = currentOnboard + increment == 3 ? currentOnboard : currentOnboard + increment
        }
        else {
            currentOnboard = currentOnboard + increment == -1 ? currentOnboard : currentOnboard + increment
        }
    }
}

#Preview {
    if #available(iOS 15.0, *) {
        Onboarding()
    } 
}
