//
//  CategoryViewMode.swift
//  SP6
//
//  Created by Евгений Михайлов on 05.01.2025.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var sneakers: [Sneaker] = []
    @Published var isLoading = false
    func fetchCategory() async throws {
        isLoading = true
        categories.removeAll()
        categories.append(Category(id: 0, name: "Все"))
        categories.append(contentsOf: try await SupabaseService.instance.fetchCategories())
        isLoading = false
    }
    func fetchSneakers() async throws {
        isLoading = true
        sneakers.append(contentsOf: try await SupabaseService.instance.fetchSneakers())
        isLoading = false
    }
}
