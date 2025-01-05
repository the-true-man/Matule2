//
//  Onboard-2.swift
//  SP6
//
//  Created by Евгений Михайлов on 05.01.2025.
//

import SwiftUI

struct Onboard_2: View {
    var body: some View {
        VStack {
            Image("onboard2")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
                .frame(height: 60)
            Text("Начнем\nпутешествие")
                .font(.system(size: 34))
                .foregroundColor(.block)
                .multilineTextAlignment(.center)
            Spacer()
                .frame(height: 12)
            Text("Умная, великолепная и модная\nколлекция Изучите сейчас")
                .font(.system(size: 16))
                .foregroundColor(.subTextLight)
                .multilineTextAlignment(.center)
            Spacer()
                .frame(height: 40)
        }
    }
}

#Preview {
    Onboarding(currentOnboard: 1)
}
