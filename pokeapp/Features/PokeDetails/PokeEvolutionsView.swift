//
//  PokeEvolutionsView.swift
//  pokeapp
//
//  Created by MAC-097419 on 07/12/23.
//

import SwiftUI

struct PokeEvolutionsView: View {
    private let evolution: EvolutionChain
    
    init(displaying evolution: EvolutionChain) {
        self.evolution = evolution
    }
    
    private let columns = [GridItem(.fixed(157)), GridItem(.fixed(157))]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(evolution.list) { pokemon in
                    PokemonListItemView(of: pokemon)
                }
            }
        }
    }
}

#Preview {
    PokeEvolutionsView(
        displaying: EvolutionChain(
            id: 1,
            chain: ChainLink(
                species: NamedApiResponse(
                    name: "Bulbasaur",
                    url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1")!
                ),
                evolvesTo: [
                    ChainLink(
                        species: NamedApiResponse(
                            name: "Ivisaur",
                            url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2")!
                        ),
                        evolvesTo: [
                            ChainLink(
                                species: NamedApiResponse(
                                    name: "Venusaur",
                                    url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3")!
                                ),
                                evolvesTo: []
                            )
                        ]
                    )
                ]
            )
        )
    )
}
