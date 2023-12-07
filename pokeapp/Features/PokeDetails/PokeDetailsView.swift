//
//  PokeDetailsView.swift
//  pokeapp
//
//  Created by MAC-097419 on 07/12/23.
//

import SwiftUI
import SDWebImageSwiftUI

enum PokeDetailTab {
    case summary
    case evolutions
}

struct PokeDetailsView: View {
    @ObservedObject private var viewModel: PokeDetailsViewModel
    @State private var tab: PokeDetailTab = .summary
    
    init(for pokemon: NamedApiResponse) {
        self.viewModel = PokeDetailsViewModel(for: pokemon)
        UISegmentedControl.appearance().selectedSegmentTintColor = .secondary800
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.primary800)], for: .normal)
    }
    
    var body: some View {
        ZStack {
            Color.light800.ignoresSafeArea()
            if let pokemon = viewModel.pokemon, let evolutions = viewModel.evolutions {
                VStack(spacing: 25) {
                    segmentedTab()
                    switch tab {
                    case .summary:
                        PokeInfoAndSkillsView(of: pokemon)
                    case .evolutions:
                        PokeEvolutionsView(displaying: evolutions)
                    }
                    
                }.padding()
            } else {
                if viewModel.isLoading {
                    ProgressView().controlSize(.large)
                }
                if viewModel.isError {
                    ErrorView {
                        viewModel.getPokemonDetails()
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationBackButton(label: "#\(viewModel.pokemonResponse.id) \(viewModel.pokemonResponse.name.capitalized)")
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear(perform: viewModel.getPokemonDetails)
    }
    
    private func segmentedTab() -> some View {
        Picker("tab", selection: $tab) {
            Text("Summary").tag(PokeDetailTab.summary)
            Text("Evolutions").tag(PokeDetailTab.evolutions)
        }.pickerStyle(.segmented)
    }
    
}

#Preview {
    PokeDetailsView(for: NamedApiResponse(name: "clefairy", url: URL(string: "https://pokeapi.co/api/v2/pokemon/35")!))
}

#Preview {
    NavigationView {
        NavigationLink {
            PokeDetailsView(for: NamedApiResponse(name: "clefairy", url: URL(string: "https://pokeapi.co/api/v2/pokemon/35")!)).navigationBarTitleDisplayMode(.inline)
        } label: {
            Text("See pokemon detail")
        }
    }
}
