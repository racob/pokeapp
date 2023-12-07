//
//  PokeListViewModel.swift
//  pokeapp
//
//  Created by MAC-097419 on 07/12/23.
//

import Foundation

final class PokeListViewModel: ObservableObject {
    @Published var pokemons: [NamedApiResponse] = []
    @Published var isLoading: Bool = true
    @Published var isError: Bool = false
    private var page = 0
    
    private let pokemonRepository: PokemonRepository
    
    init(pokemonRepository: PokemonRepository = PokemonRepository()) {
        self.pokemonRepository = pokemonRepository
    }
    
    func getPokemons() {
        Task {
            isLoading = true
            isError = false
            do {
                // 2 second delay to show loading
                try await Task.sleep(nanoseconds: 2_000_000_000)
                
                pokemons += try await pokemonRepository.getPokemons(page: page)
                page += 1
            } catch {
                isError = true
            }
            isLoading = false
        }
    }
}
