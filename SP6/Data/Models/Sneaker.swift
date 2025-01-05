//
//  Sneakers.swift
//  SP6
//
//  Created by Евгений Михайлов on 05.01.2025.
//

import Foundation

struct Sneaker: Identifiable, Decodable {
    let id: String
    let name: String
    let price: Double
    let category: Int
    let description: String
    let bestseller: Bool
    let fullname: String
    var image: URL?
}
