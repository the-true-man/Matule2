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
     
}
