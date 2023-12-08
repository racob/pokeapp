//
//  PokemonSpecies.swift
//  pokeapp
//
//  Created by MAC-097419 on 08/12/23.
//

import Foundation
import RealmSwift

class PokemonSpecies: Object {
    @Persisted var id: Int
    @Persisted var evolutionChain: SpeciesEvolutionChain?
}

class SpeciesEvolutionChain: Object {
    @Persisted var url: String
}
