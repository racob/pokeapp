//
//  PokemonRepository.swift
//  pokeapp
//
//  Created by MAC-097419 on 05/12/23.
//

import Foundation

class PokemonRepository {
    
    private let networkDataSource: PokemonNetworkDataSource
    private let localDataSource: PokemonLocalDataSource
    
    init(
        networkDataSource: PokemonNetworkDataSource = PokemonNetworkDataSource(),
        localDataSource: PokemonLocalDataSource = PokemonLocalDataSource()
    ) {
        self.networkDataSource = networkDataSource
        self.localDataSource = localDataSource
    }
    
    func getPokemons(page: Int = 0) async throws -> [NamedApiResponse] {
        try await networkDataSource.getPokemons(page: page)
    }
    
    func getPokemonDetails(id: String) async throws -> PokemonResponse {
        if let pokemon = localDataSource.getPokemonDetail(with: id) {
            return pokemon
        } else {
            let response = try await networkDataSource.getPokemonDetail(id: id)
            localDataSource.savePokemonDetail(response)
            return response
        }
    }
    
    func getSpecies(id: String) async throws -> PokemonSpeciesResponse {
        if let species = localDataSource.getPokemonSpecies(with: id) {
            return species
        } else {
            let response = try await networkDataSource.getSpecies(id: id)
            localDataSource.savePokemonSpecies(response)
            return response
        }
    }
    
    func getEvolutions(evolutionId: String) async throws -> EvolutionChainResponse {
        if let evolutions = localDataSource.getEvolutions(with: evolutionId) {
            return evolutions
        } else {
            let response = try await networkDataSource.getEvolutions(evolutionId: evolutionId)
            localDataSource.saveEvolutions(response)
            return response
        }
    }
}
