//
//  EvolutionChainResponse.swift
//  pokeapp
//
//  Created by MAC-097419 on 07/12/23.
//

import Foundation

struct EvolutionChainResponse: Codable, Equatable {
    let id: Int
    let chain: ChainLinkResponse
    
    var list: [NamedApiResponse] {
        getAllSpecies(from: chain)
    }
    
    private func getAllSpecies(from chainLink: ChainLinkResponse) -> [NamedApiResponse] {
        var allSpecies = [chainLink.species]
        
        for nextLink in chainLink.evolvesTo {
            let nextSpecies = getAllSpecies(from: nextLink)
            allSpecies.append(contentsOf: nextSpecies)
        }
        
        return allSpecies
    }
}

struct ChainLinkResponse: Codable, Equatable {
    let species: NamedApiResponse
    let evolvesTo: [ChainLinkResponse]
}
