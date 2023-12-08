//
//  EvolutionChain.swift
//  pokeapp
//
//  Created by MAC-097419 on 07/12/23.
//

import Foundation

struct EvolutionChain: Codable, Equatable {
    let id: Int
    let chain: ChainLink
    
    var list: [NamedApiResponse] {
        getAllSpecies(from: chain)
    }
    
    private func getAllSpecies(from chainLink: ChainLink) -> [NamedApiResponse] {
        var allSpecies = [chainLink.species]
        
        for nextLink in chainLink.evolvesTo {
            let nextSpecies = getAllSpecies(from: nextLink)
            allSpecies.append(contentsOf: nextSpecies)
        }
        
        return allSpecies
    }
}

struct ChainLink: Codable, Equatable {
    let species: NamedApiResponse
    let evolvesTo: [ChainLink]
}


