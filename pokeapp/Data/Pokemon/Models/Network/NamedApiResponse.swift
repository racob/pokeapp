//
//  NamedApiResponse.swift
//  pokeapp
//
//  Created by MAC-097419 on 05/12/23.
//

import Foundation

struct ListResponse<T: Codable>: Codable {
    let results: [T]
}

struct NamedApiResponse: Identifiable, Codable, Hashable {
    let name: String
    let url: URL
}

extension NamedApiResponse {
    var id: String {
        return url.lastPathComponent
    }
    
    var imageUrl: URL {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")!
    }
}
