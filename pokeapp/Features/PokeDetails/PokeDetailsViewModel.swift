//
//  PokeDetailsViewModel.swift
//  pokeapp
//
//  Created by MAC-097419 on 07/12/23.
//

import Foundation

final class PokeDetailsViewModel: ObservableObject {
    let pokemonResponse: NamedApiResponse
    @Published var pokemon: PokemonResponse?
    @Published var evolutions: EvolutionChainResponse?
    @Published var isLoading: Bool = true
    @Published var isError: Bool = false
    
    private let pokemonRepository: PokemonRepository
    
    init(for pokemon: NamedApiResponse, pokemonRepository: PokemonRepository = PokemonRepository()) {
        self.pokemonResponse = pokemon
        self.pokemonRepository = pokemonRepository
    }
    
    @MainActor func getPokemonDetails() {
        isLoading = true
        isError = false
        Task {
            do {
                let species = try await pokemonRepository.getSpecies(id: String(pokemonResponse.id))
                pokemon = try await pokemonRepository.getPokemonDetails(id: String(pokemonResponse.id))
                evolutions = try await pokemonRepository.getEvolutions(evolutionId: species.evolutionChain.id)
            } catch {
                pokemon = nil
                debugPrint(error)
                isError = true
            }
            isLoading = false
        }
    }
}
