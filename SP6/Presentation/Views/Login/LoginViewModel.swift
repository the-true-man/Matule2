//
//  LoginViewModel.swift
//  SP6
//
//  Created by Евгений Михайлов on 07.01.2025.
//

import Foundation

@MainActor
class LoginViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var isLogin: Bool = false
    
    func login(email: String, password: String) {
        Task {
            isLoading = true
            do {
                try await SupabaseService.instance.Auth(email: email, password: password)

            }catch {
                print(error.localizedDescription)
            }
            isLoading = false

        }
    }
}
