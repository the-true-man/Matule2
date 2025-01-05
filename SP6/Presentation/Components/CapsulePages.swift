//
//  CapsulePages.swift
//  SP6
//
//  Created by Евгений Михайлов on 05.01.2025.
//

import SwiftUI

struct CapsulePages: View {
    @Binding var currentPages: Int
    var countPages: Int = 3
    var body: some View {
        HStack(spacing: 12){
            ForEach(0..<countPages) { index in
                Capsule()
                    .foregroundColor(index == currentPages ? .block : .disable)
                    .frame(width: index == currentPages ? 43 : 28, height: 5)
            }
        }
    }
}

#Preview {
    CapsulePages(currentPages: .constant(1))
}
