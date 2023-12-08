//
//  PokemonSpecies.swift
//  pokeapp
//
//  Created by MAC-097419 on 07/12/23.
//

import Foundation

struct PokemonSpeciesResponse: Codable, Equatable {
    let id: Int
    let evolutionChain: Self.EvolutionChainResponse
    
    struct EvolutionChainResponse: Codable, Equatable {
        let url: URL
        
        var id: String {
            return url.lastPathComponent
        }
    }
}
