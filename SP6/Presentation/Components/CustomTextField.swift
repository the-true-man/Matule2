//
//  CustomTextField.swift
//  SP6
//
//  Created by Евгений Михайлов on 07.01.2025.
//

import SwiftUI

struct CustomTextField: View {
    var label: String
    @Binding var text: String
    var placeholder: String
    var isSecure: Bool
    @State var showPassword = false
    @FocusState var isFocus
    init(label: String, text: Binding<String>, placeholder: String, isSecure: Bool = false) {
        self.label = label
        self._text = text
        self.placeholder = placeholder
        self.isSecure = isSecure
    }
    var body: some View {
        VStack(alignment: .leading){
            Group {
                Text(label)
                
                    .font(.system(size: 16))
                    .foregroundColor(.text)
                Spacer()
                    .frame(height: 12)
                ZStack(alignment: .leading){
                    
                    if !isSecure {
                        TextField(placeholder, text: $text)
                            .textFieldStyle(CustomStyleTextField())
                    }
                    else {
                        ZStack(alignment: .trailing){
                            if showPassword {
                                TextField(placeholder, text: $text)
                                    .textFieldStyle(CustomStyleTextField())
                            }
                            else {
                                SecureField(placeholder, text: $text)
                                    .textFieldStyle(CustomStyleTextField())
                            }
                            Button(action: {showPassword.toggle()}) {
                                Image(systemName: showPassword ? "eye" : "eye.slash")
                                    .foregroundColor(.hint)
                            }
                            .padding(.trailing, 14)
                            
                        }
                        
                    }
                    if text.isEmpty {
                        Text(placeholder)
                            .foregroundColor(.hint)
                            .font(.system(size: 14))
                            .padding(.leading, 14)
                    }
                    
                }
            }
        }
        .focused($isFocus)
        .onTapGesture {isFocus = true}
    }
}

#Preview {
    CustomTextField(label: "Email", text: .constant(""), placeholder: "xyz@gmail.com", isSecure: true)
}
