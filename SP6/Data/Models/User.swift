//
//  User.swift
//  SP6
//
//  Created by Евгений Михайлов on 07.01.2025.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
}
