//
//  PokemonNetworkDataSource.swift
//  pokeapp
//
//  Created by MAC-097419 on 05/12/23.
//

import Alamofire

class PokemonNetworkDataSource {
    
    private let baseUrl = "https://pokeapi.co/api/v2"
    
    func getPokemons(page: Int = 0) async throws -> [NamedApiResponse] {
        let result = await AF.request("\(baseUrl)/pokemon?offset=\(page * 20)").serializingDecodable(ListResponse<NamedApiResponse>.self, decoder: JSONSnakeCase.decoder()).result
        switch result {
        case .success(let response):
            return response.results
        case .failure(let error):
            debugPrint(error)
            throw error
        }
    }
    
    func getPokemonDetail(id: String) async throws -> Pokemon {
        let result = await AF.request("\(baseUrl)/pokemon/\(id)").serializingDecodable(Pokemon.self, decoder: JSONSnakeCase.decoder()).result
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            debugPrint(error)
            throw error
        }
    }
    
    func getSpecies(id: String) async throws -> PokemonSpecies {
        let result = await AF.request("\(baseUrl)/pokemon-species/\(id)").serializingDecodable(PokemonSpecies.self, decoder: JSONSnakeCase.decoder()).result
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            debugPrint(error)
            throw error
        }
    }
    
    func getEvolutions(evolutionId: String) async throws -> EvolutionChain {
        let result = await AF.request("\(baseUrl)/evolution-chain/\(evolutionId)").serializingDecodable(EvolutionChain.self, decoder: JSONSnakeCase.decoder()).result
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            debugPrint(error)
            throw error
        }
    }
}
