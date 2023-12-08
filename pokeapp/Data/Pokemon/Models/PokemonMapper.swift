//
//  PokemonMapper.swift
//  pokeapp
//
//  Created by MAC-097419 on 08/12/23.
//

import Foundation
import RealmSwift

extension NamedApi {
    convenience init(from response: NamedApiResponse) {
        self.init()
        self.name = response.name
        self.url = response.url.absoluteString
    }
}

extension Pokemon {
    convenience init(from response: PokemonResponse) {
        self.init()
        self.id = response.id
        self.name = response.name
        self.height = response.height
        self.weight = response.weight
        
        response.stats.forEach { statResponse in
            let stat = Stat(from: statResponse)
            self.stats.append(stat)
        }
        
        response.types.forEach { typeResponse in
            let pokeType = PokeType(from: typeResponse)
            self.types.append(pokeType)
        }
    }
}

extension Stat {
    convenience init(from response: StatResponse) {
        self.init()
        self.baseStat = response.baseStat
        self.stat = NamedApi(from: response.stat)
    }
}

extension PokeType {
    convenience init(from response: PokeTypeResponse) {
        self.init()
        self.slot = response.slot
        self.type = NamedApi(from: response.type)
    }
}

extension PokemonSpecies {
    convenience init(from response: PokemonSpeciesResponse) {
        self.init()
        self.id = response.id
        self.evolutionChain = SpeciesEvolutionChain(from: response.evolutionChain)
    }
}

extension SpeciesEvolutionChain {
    convenience init(from response: PokemonSpeciesResponse.EvolutionChainResponse) {
        self.init()
        self.url = response.url.absoluteString
    }
}

extension EvolutionChain {
    convenience init(from response: EvolutionChainResponse) {
        self.init()
        self.id = response.id
        self.chain = ChainLink(from: response.chain)
    }
}

extension ChainLink {
    convenience init(from response: ChainLinkResponse) {
        self.init()
        self.species = NamedApi(from: response.species)
        response.evolvesTo.forEach { chainLinkResponse in
            self.evolvesTo.append(ChainLink(from: chainLinkResponse))
        }
    }
}

extension NamedApiResponse {
    init(from object: NamedApi) {
        self.init(name: object.name, url: URL(string: object.url)!)
    }
}

extension PokemonResponse {
    init(from object: Pokemon) {
        self.init(
            id: object.id,
            name: object.name,
            height: object.height,
            weight: object.weight,
            stats: object.stats.map{StatResponse(from: $0)},
            types: object.types.map{PokeTypeResponse(from: $0)}
        )
    }
}

extension StatResponse {
    init(from object: Stat) {
        self.init(baseStat: object.baseStat, stat: NamedApiResponse(from: object.stat!))
    }
}

extension PokeTypeResponse {
    init(from object: PokeType) {
        self.init(slot: object.slot, type: NamedApiResponse(from: object.type!))
    }
}

extension PokemonSpeciesResponse {
    init(from object: PokemonSpecies) {
        self.init(
            id: object.id,
            evolutionChain: PokemonSpeciesResponse.EvolutionChainResponse(
                url: URL(string: object.evolutionChain!.url)!
            )
        )
    }
}

extension EvolutionChainResponse {
    init(from object: EvolutionChain) {
        self.id = object.id
        self.chain = ChainLinkResponse(from: object.chain!)
    }
}

extension ChainLinkResponse {
    init(from object: ChainLink) {
        self.species = NamedApiResponse(from: object.species!)
        self.evolvesTo = object.evolvesTo.map { ChainLinkResponse(from: $0) }
    }
}
