//
//  PokemonResponse.swift
//  pokeapp
//
//  Created by MAC-097419 on 07/12/23.
//

import Foundation

struct PokemonResponse: Codable, Equatable {
    let id: Int
    let name: String
    let height: Int // in decimeters
    let weight: Int // in hectograms
    let stats: [StatResponse]
    let types: [PokeTypeResponse]
    
    var heightInMeter: String {
        String(format: "%.1f", Double(height) / 10.0)
    }
    
    var weightInKg: String {
        String(format: "%.1f", Double(weight) / 10.0)
    }
    
    var attack: String {
        guard let value = stats.first(where: {$0.stat.name.lowercased() == "attack"})?.baseStat else { return "" }
        return String(value)
    }
    
    var hp: String {
        guard let value = stats.first(where: {$0.stat.name.lowercased() == "hp"})?.baseStat else { return "" }
        return String(value)
    }
    
    var defense: String {
        guard let value = stats.first(where: {$0.stat.name.lowercased() == "defense"})?.baseStat else { return "" }
        return String(value)
    }
    
    var speed: String {
        guard let value = stats.first(where: {$0.stat.name.lowercased() == "speed"})?.baseStat else { return "" }
        return String(value)
    }
    
    var allTypesString: String {
        types.sorted{$0.slot < $1.slot}
            .map{$0.type.name.capitalized}
            .joined(separator: ", ")
    }
    
    var imageUrl: URL {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")!
    }
}

struct StatResponse: Codable, Equatable {
    let baseStat: Int
    let stat: NamedApiResponse
}

struct PokeTypeResponse: Codable, Equatable {
    let slot: Int
    let type: NamedApiResponse
}
