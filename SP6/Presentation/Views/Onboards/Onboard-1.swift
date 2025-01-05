//
//  Onboard-1.swift
//  SP6
//
//  Created by Евгений Михайлов on 05.01.2025.
//

import SwiftUI

struct Onboard_1: View {
    var body: some View {
        VStack{
            Text("добро\nпожаловать".uppercased())
                .multilineTextAlignment(.center)
                .font(.system(size: 30))
                .foregroundColor(.block)
            Spacer()
                .frame(height: 130)
            Image("onboard1")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
                .frame(height: 21)
        }
    }
}

#Preview {
    Onboarding()
}
