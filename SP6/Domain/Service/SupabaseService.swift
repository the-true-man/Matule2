//
//  SupabaseService.swift
//  SP6
//
//  Created by Евгений Михайлов on 05.01.2025.
//

import Foundation
import Supabase

class SupabaseService {
    let supabase: SupabaseClient = SupabaseClient(supabaseURL: URL(string: "https://smueyuadnkwfxxzkupej.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNtdWV5dWFkbmt3Znh4emt1cGVqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE3NDcxMTYsImV4cCI6MjA0NzMyMzExNn0.diZuAMATbCdbuvFeSQafXLHdLLIfJ_3bEA7FbuyWof8")
    static let instance = SupabaseService()
    
    func fetchCategories() async throws -> [Category] {
        try await supabase.from("categories").select().execute().value
    }
    func fetchSneakers() async throws -> [Sneaker] {
        var sneakers: [Sneaker] = try await supabase.from("sneakers").select().execute().value
        for i in sneakers.indices {
            sneakers[i].image = try await fetchImage(path:"\(sneakers[i].id).png")
        }
        return sneakers
    }
    
    func fetchImage(path: String) async throws -> URL {
        try supabase.storage.from("assets").getPublicURL(path: path, download: false)
    }
    
    func fetchAds() async throws -> URL {
        let response = try await supabase.from("ads").select().execute().data
        let ads = try JSONDecoder().decode([Ads].self, from: response)
        return try supabase.storage.from("ads").getPublicURL(path: "\(ads.first!.id).png", download: false)
    }
    
    func loginUser(email: String, password: String) async throws {
        try await supabase.auth.signIn(email: email, password: password)
    }
    func getFavorite(userId: String) async throws -> [Sneaker] {
        let favoriteSneakersResponse: [[String:String]] = try await supabase
            .from("favorites")
            .select("sneaker")
            .eq("user", value: userId)
            .execute()
            .value
        let favoriteSneakersId: [String] = favoriteSneakersResponse.compactMap{$0["sneaker"]}
        
        var favoriteSneakers: [Sneaker] = []
        for i in favoriteSneakersId {
            favoriteSneakers = try await supabase.from("sneakers").select().eq("id", value: i).execute().value
        }
        for i in favoriteSneakers.indices {
            favoriteSneakers[i].image = try await fetchImage(path: "\(favoriteSneakers[i].id).png")
        }
        return favoriteSneakers
    }
    
    func addFavorite(idSneaker: String, idUser: String) async throws {
        try await supabase.from("favorites").insert(["sneaker": idSneaker, "user": idUser]).execute()
    }
    
    func deleteFavorite(idSneaker: String, idUser: String) async throws {
        try await supabase.from("favorites")
            .delete()
            .eq("sneaker", value: idSneaker)
            .eq("user", value: idUser)
            .execute()
    }
    
     
}
