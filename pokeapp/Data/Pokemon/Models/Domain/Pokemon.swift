//
//  Pokemon.swift
//  pokeapp
//
//  Created by MAC-097419 on 08/12/23.
//

import Foundation
import RealmSwift

class Pokemon: Object {
    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var height: Int // in decimeters
    @Persisted var weight: Int // in hectograms
    @Persisted var stats: List<Stat>
    @Persisted var types: List<PokeType>
    
    var heightInMeter: String {
        String(format: "%.1f", Double(height) / 10.0)
    }
    
    var weightInKg: String {
        String(format: "%.1f", Double(weight) / 10.0)
    }
    
    var attack: String {
        guard let value = stats.first(where: {$0.stat?.name.lowercased() == "attack"})?.baseStat else { return "??" }
        return String(value)
    }
    
    var hp: String {
        guard let value = stats.first(where: {$0.stat?.name.lowercased() == "hp"})?.baseStat else { return "??" }
        return String(value)
    }
    
    var defense: String {
        guard let value = stats.first(where: {$0.stat?.name.lowercased() == "defense"})?.baseStat else { return "??" }
        return String(value)
    }
    
    var speed: String {
        guard let value = stats.first(where: {$0.stat?.name.lowercased() == "speed"})?.baseStat else { return "??" }
        return String(value)
    }
    
    var allTypesString: String {
        types.map{$0.type?.name.capitalized ?? "??"}
            .sorted(by: <)
            .joined(separator: ", ")
    }
    
    var imageUrl: URL {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")!
    }
}

class Stat: Object {
    @Persisted var baseStat: Int
    @Persisted var stat: NamedApi?
}

class PokeType: Object {
    @Persisted var slot: Int
    @Persisted var type: NamedApi?
}
