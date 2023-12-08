//
//  EvolutionChain.swift
//  pokeapp
//
//  Created by MAC-097419 on 08/12/23.
//

import Foundation
import RealmSwift

class EvolutionChain: Object {
    @Persisted var id: Int
    @Persisted var chain: ChainLink?
}

class ChainLink: Object {
    @Persisted var species: NamedApi?
    @Persisted var evolvesTo: List<ChainLink>
}
