//
//  PokemonRepository.swift
//  pokeapp
//
//  Created by MAC-097419 on 05/12/23.
//

import Foundation

class PokemonRepository {
    
    private let networkDataSource: PokemonNetworkDataSource
    
    init(networkDataSource: PokemonNetworkDataSource = PokemonNetworkDataSource()) {
        self.networkDataSource = networkDataSource
    }
    
    func getPokemons(page: Int = 0) async throws -> [NamedApiResponse] {
        try await networkDataSource.getPokemons(page: page)
    }
    
    func getPokemonDetails(id: String) async throws -> Pokemon {
        try await networkDataSource.getPokemonDetail(id: id)
    }
    
    func getSpecies(id: String) async throws -> PokemonSpecies {
        try await networkDataSource.getSpecies(id: id)
    }
    
    func getEvolutions(evolutionId: String) async throws -> EvolutionChain {
        try await networkDataSource.getEvolutions(evolutionId: evolutionId)
    }
}
