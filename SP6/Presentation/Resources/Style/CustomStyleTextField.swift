//
//  CustomStyleTextField.swift
//  SP6
//
//  Created by Евгений Михайлов on 07.01.2025.
//

import SwiftUI

struct CustomStyleTextField: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .frame(maxWidth: .infinity, maxHeight: 48)
            .font(.system(size: 14))
            .foregroundColor(.text)
            .padding(.horizontal, 14)
            .background(Color.background)

            .cornerRadius(15)
            .autocorrectionDisabled()
            .autocapitalization(.none)
        
    }
}
