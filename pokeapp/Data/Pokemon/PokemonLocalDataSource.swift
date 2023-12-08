//
//  PokemonLocalDataSource.swift
//  pokeapp
//
//  Created by MAC-097419 on 08/12/23.
//

import Foundation

final class PokemonLocalDataSource {
    
    private let persistentManager: PersistentManager
    
    init(persistentManager: PersistentManager = PersistentManager.shared) {
        self.persistentManager = persistentManager
    }
    
    func getPokemonDetail(with id: String) -> PokemonResponse? {
        let result = persistentManager.fetchObjects(ofType: Pokemon.self, withQuery: "id == \(id)")
        guard let pokemon = result?.first else { return nil }
        return PokemonResponse(from: pokemon)
    }
    
    func savePokemonDetail(_ pokemon: PokemonResponse) {
        persistentManager.addObject(Pokemon(from: pokemon))
    }
    
    func getPokemonSpecies(with id: String) -> PokemonSpeciesResponse? {
        let result = persistentManager.fetchObjects(ofType: PokemonSpecies.self, withQuery: "id == \(id)" )
        guard let species = result?.first else { return nil }
        return PokemonSpeciesResponse(from: species)
    }
    
    func savePokemonSpecies(_ species: PokemonSpeciesResponse) {
        persistentManager.addObject(PokemonSpecies(from: species))
    }
    
    func getEvolutions(with evolutionId: String) -> EvolutionChainResponse? {
        let result = persistentManager.fetchObjects(ofType: EvolutionChain.self, withQuery: "id == \(evolutionId)" )
        guard let evolutionChain = result?.first else { return nil }
        return EvolutionChainResponse(from: evolutionChain)
    }
    
    func saveEvolutions(_ evolutionChain: EvolutionChainResponse) {
        persistentManager.addObject(EvolutionChain(from: evolutionChain))
    }
}
