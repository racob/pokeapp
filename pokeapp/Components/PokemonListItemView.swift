//
//  PokemonListItemView.swift
//  pokeapp
//
//  Created by MAC-097419 on 07/12/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonListItemView: View {
    private let pokemon: NamedApiResponse
    
    init(of pokemon: NamedApiResponse) {
        self.pokemon = pokemon
    }
    
    init(of pokemon: NamedApi) {
        self.init(of: NamedApiResponse(name: pokemon.name, url: URL(string: pokemon.url)!))
    }
    
    var body: some View {
        NavigationLink {
            PokeDetailsView(for: pokemon)
        } label: {
            ContainerView {
                VStack {
                    WebImage(url: pokemon.imageUrl).indicator(.activity)
                    Text("#\(pokemon.id) " + pokemon.name.capitalized).fontWeight(.semibold)
                }.frame(width: 157, height: 157)
            }
        }
    }
}

#Preview {
    PokemonListItemView(
        of: NamedApiResponse(
            name: "Bulbasaur",
            url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1")!
        )
    )
}
