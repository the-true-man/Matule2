//
//  CategoryViewMode.swift
//  SP6
//
//  Created by Евгений Михайлов on 05.01.2025.
//

import Foundation
import Combine
import SwiftUI
import Auth
@MainActor
class HomeViewModel: ObservableObject {
    @Published var user: User?
    @Published var categories: [Category] = []
    @Published var sneakers: [Sneaker] = []
    @Published var favorites: [Sneaker] = []
    @Published var isLoading = false
    @Published var ads: URL?
    @Published var selectedCategory: Int = -1
    @Published var selectedView: Int = 0
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
        fetchUser()
        fetchFavorite()
        fetchCategory()
        fetchSneakers()
        fetchAds()
    }
    func fetchUser() {
        Task {
            do {
                user = try await SupabaseService.instance.supabase.auth.session.user
            }
            catch {
                print(error.localizedDescription)
            }
        }
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
    func fetchFavorite() {
        
        Task {
            isLoading = true
            if let user = user {
                do {
                    favorites = try await SupabaseService.instance.getFavorite(userId: user.id.uuidString)
                    
                }
                catch {
                    isNetworkError = true
                    print(error.localizedDescription)
                    return
                }
            }
            isLoading = false
        }
    }
    func addAndDeleteToFavorite(selectSneaker: Sneaker)  {
        if favorites.contains(where: { $0.id == selectSneaker.id }) {
            if let index = favorites.firstIndex(where: { $0.id == selectSneaker.id }) {
                Task {
                    do {
                        try await SupabaseService.instance.deleteFavorite(idSneaker: selectSneaker.id, idUser: user!.id.uuidString)
                        favorites.remove(at: index)

                    }
                    catch {
                        isNetworkError = true
                        print(error.localizedDescription)
                    }
                }
            }
        }
        else {
            Task {
                do {
                    try await SupabaseService.instance.addFavorite(idSneaker: selectSneaker.id, idUser: user!.id.uuidString)
                    favorites.append(selectSneaker)
                }
                catch {
                    isNetworkError = true
                    print(error.localizedDescription)
                }
            }
        }
    }
}

