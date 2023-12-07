//
//  PokemonSpecies.swift
//  pokeapp
//
//  Created by MAC-097419 on 07/12/23.
//

import Foundation

struct PokemonSpecies: Codable {
    let id: Int
    let evolutionChain: Self.EvolutionChain
    
    struct EvolutionChain: Codable {
        let url: URL
        
        var id: String {
            return url.lastPathComponent
        }
    }
}
