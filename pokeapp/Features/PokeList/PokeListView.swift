//
//  HomeView.swift
//  pokeapp
//
//  Created by MAC-097419 on 05/12/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokeListView: View {
    @StateObject private var viewModel = PokeListViewModel()
    
    private let columns = [GridItem(.fixed(157)), GridItem(.fixed(157))]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.light800.ignoresSafeArea()
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(viewModel.pokemons) { pokemon in
                            PokemonListItemView(of: pokemon)
                        }
                        Color.clear.onAppear(perform: viewModel.getPokemons)
                    }
                    if !viewModel.pokemons.isEmpty {
                        nextPageView()
                    }
                }.overlay {
                    if viewModel.pokemons.isEmpty {
                        if viewModel.isLoading {
                            ProgressView().controlSize(.large)
                        }
                        if viewModel.isError {
                            ErrorView(onTappedRetry: viewModel.getPokemons)
                        }
                    }
                    
                }
            }
            .onAppear(perform: viewModel.getPokemons)
        }
    }
    
    private func nextPageView() -> some View {
        ZStack(alignment: .center) {
            if viewModel.isLoading {
                ProgressView().controlSize(.large)
            } else {
                EmptyView()
            }
        }
    }
}

#Preview {
    PokeListView()
}
