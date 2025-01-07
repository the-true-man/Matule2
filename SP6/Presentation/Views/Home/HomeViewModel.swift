//
//  CategoryViewMode.swift
//  SP6
//
//  Created by Евгений Михайлов on 05.01.2025.
//

import Foundation
import Combine
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var sneakers: [Sneaker] = []
    @Published var isLoading = false
    @Published var ads: URL?
    @Published var selectedCategory: Int = -1
    @Published var isNetworkError: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    init() {
        fetchData()
        NetworkMonitor.shared.$isConnected.sink {[weak self] isConnected in
            DispatchQueue.main.async {
                if !isConnected {
                    self?.isLoading = true
                    self?.isNetworkError = true
                }
            }
        }
        .store(in: &cancellables)
    }
    func fetchData() {
        fetchCategory()
        fetchSneakers()
        fetchAds()
    }
    func fetchCategory() {
        Task {
            isLoading = true
            do {
                categories.removeAll()
                categories.append(Category(id: 0, name: "Все"))
                let categories = try await SupabaseService.instance.fetchCategories()
                self.categories.append(contentsOf: categories)
            }
            catch {
                categories.removeAll()
                isNetworkError = true
                print(error.localizedDescription)
                return
            }
            
            isLoading = false
        }
        
    }
    func fetchSneakers() {
        Task {
            isLoading = true
            do {
                let sneakers = try await SupabaseService.instance.fetchSneakers()
                self.sneakers = sneakers
            }
            catch {
                isNetworkError = true
                sneakers.removeAll()
                print(error.localizedDescription)
                return
            }
            isLoading = false
        }
        
    }
    func fetchAds() {
        Task {
            isLoading = true
            do {
                ads = try await SupabaseService.instance.fetchAds()
            }
            catch {
                isNetworkError = true
                print(error.localizedDescription)
                return

            }
            isLoading = false
        }
        
    }
}
