//
//  PokeEvolutionsView.swift
//  pokeapp
//
//  Created by MAC-097419 on 07/12/23.
//

import SwiftUI

struct PokeEvolutionsView: View {
    private let evolution: EvolutionChainResponse
    
    init(displaying evolution: EvolutionChainResponse) {
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
        displaying: EvolutionChainResponse(
            id: 1,
            chain: ChainLinkResponse(
                species: NamedApiResponse(
                    name: "Bulbasaur",
                    url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1")!
                ),
                evolvesTo: [
                    ChainLinkResponse(
                        species: NamedApiResponse(
                            name: "Ivisaur",
                            url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2")!
                        ),
                        evolvesTo: [
                            ChainLinkResponse(
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
