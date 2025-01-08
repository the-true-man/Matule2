//
//  LoginViewModel.swift
//  SP6
//
//  Created by Евгений Михайлов on 07.01.2025.
//

import Foundation
import Auth
@MainActor
class LoginViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var isLogin: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    func login(email: String, password: String) {
        Task {
            isLoading = true
            do {
                try await SupabaseService.instance.loginUser(email: email, password: password)
                isLogin = true

            }catch {
                if let supabaseError = error as? AuthError {
                    switch supabaseError.errorCode {
                    case .invalidCredentials:
                        errorMessage = "Неверный email или пароль"
                    default:
                        errorMessage = supabaseError.localizedDescription
                    }
                }
                else if let netWorkError = error as? URLError {
                    switch netWorkError.code {
                    case .notConnectedToInternet:
                        errorMessage = "Нет подключения к интернету"
                    default:
                        errorMessage = netWorkError.localizedDescription
                    }
                }
                else  {
                    errorMessage = error.localizedDescription
                }
                isError = true
            }
            isLoading = false

        }
    }
}
