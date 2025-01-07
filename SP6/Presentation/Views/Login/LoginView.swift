//
//  LoginView.swift
//  SP6
//
//  Created by Евгений Михайлов on 07.01.2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject var model = LoginViewModel()
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                
                Text("Привет!")
                    .font(.system(size: 32))
                    .foregroundColor(.text)
                Spacer()
                    .frame(height: 8)
                Text("Заполните Свои данные или\nпродолжите через социальные медиа".capitalized)
                    .font(.system(size: 16))
                    .foregroundColor(.subTextDark)
                    .multilineTextAlignment(.center)
                Spacer()
                    .frame(height: 35)
                CustomTextField(label: "Email", text: $email, placeholder: "xyz@gmail.com", isSecure: false)
                Spacer()
                    .frame(height: 26)
                CustomTextField(label: "Пароль", text: $password, placeholder: "********", isSecure: true)
                Spacer()
                    .frame(height: 16)
                HStack{
                    Spacer()
                    NavigationLink(destination: EmptyView()) {
                        Text("Восстановить")
                            .font(.system(size: 12))
                            .foregroundColor(.subTextDark)
                    }
                }
                Spacer()
                    .frame(height: 24)
                Button(action: {model.login(email: email, password: password)}) {
                    Text("Войти")
                        .foregroundColor(.block)
                        .font(.system(size: 14))
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(.accent)
                        .cornerRadius(14)
                }
                Spacer()
                HStack{
                    Text("Вы впервые?")
                        .foregroundStyle(.hint)
                        .font(.system(size: 16))
                    Text("Создать пользователя")
                        .foregroundStyle(.text)
                        .font(.system(size: 16))
                }.padding(.bottom, 50)
                
                
            }
            .ignoresSafeArea(.all)
            .padding(.horizontal, 20)
            .navigationDestination(isPresented: $model.isLogin) {
                Onboarding()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    LoginView()
}
