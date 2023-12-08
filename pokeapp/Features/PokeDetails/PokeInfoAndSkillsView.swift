//
//  PokeInfoAndSkillsView.swift
//  pokeapp
//
//  Created by MAC-097419 on 07/12/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokeInfoAndSkillsView: View {
    private let pokemon: Pokemon
    
    init(of pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    var body: some View {
        VStack(spacing: 22) {
            basicInfo()
            skills()
            Spacer()
        }
    }
    
    private func basicInfo() -> some View {
        ContainerView {
            HStack {
                Spacer()
                WebImage(url: pokemon.imageUrl).indicator(.activity)
                Divider()
                    .overlay(.light800)
                    .frame(height: 77)
                VStack(alignment: .leading, spacing: 5) {
                    Text(pokemon.name.capitalized).bold()
                    Spacer().frame(height: 6)
                    Group {
                        Text("Type: \(pokemon.allTypesString)")
                        Text("Height: \(pokemon.heightInMeter) m")
                        Text("Weight: \(pokemon.weightInKg) Kg")
                    }.font(.footnote)
                }
                .foregroundStyle(.light800)
                .frame(maxWidth: .infinity)
                Spacer()
            }.padding()
        }
    }
    
    private func skills() -> some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Skills")
                    .font(.title2)
                    .foregroundStyle(.primary800)
                Divider()
            }
            skill(label: "Attack", value: pokemon.attack)
            skill(label: "HP", value: pokemon.hp)
            skill(label: "Defense", value: pokemon.defense)
            skill(label: "Speed", value: pokemon.speed)
        }
    }
    
    private func skill(label: String, value: String) -> some View {
        ContainerView {
            HStack {
                Text(label + ":")
                Spacer()
                Text(value)
            }
            .font(.callout)
            .padding(.vertical, 8)
            .padding(.leading, 15)
            .padding(.trailing, 34)
        }
    }
}

#Preview {
    PokeInfoAndSkillsView(
        of: Pokemon(
            id: 1,
            name: "Bulbasaur",
            height: 6,
            weight: 3,
            stats: [
                Stat(baseStat: 30, stat: NamedApiResponse(name: "attack", url: NSURL() as URL)),
                Stat(baseStat: 30, stat: NamedApiResponse(name: "hp", url: NSURL() as URL)),
                Stat(baseStat: 30, stat: NamedApiResponse(name: "defense", url: NSURL() as URL)),
                Stat(baseStat: 30, stat: NamedApiResponse(name: "speed", url: NSURL() as URL))
            ],
            types: [
                PokeType(slot: 1, type: NamedApiResponse(name: "Leaf", url: NSURL() as URL))
            ]
        )
    ).padding()
}
