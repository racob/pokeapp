//
//  PokemonNetworkDataSource.swift
//  pokeapp
//
//  Created by MAC-097419 on 05/12/23.
//

import Alamofire

final class PokemonNetworkDataSource {
    private let baseUrl = "https://pokeapi.co/api/v2"
    
    private let sessionManager: Session
    
    init(sessionManager: Session = Session()) {
        self.sessionManager = sessionManager
    }
    
    func getPokemons(page: Int = 0) async throws -> [NamedApiResponse] {
        let result = await sessionManager.request("\(baseUrl)/pokemon?offset=\(page * 20)").serializingDecodable(ListResponse<NamedApiResponse>.self, decoder: JSONSnakeCase.decoder()).result
        switch result {
        case .success(let response):
            return response.results
        case .failure(let error):
            debugPrint(error)
            throw error
        }
    }
    
    func getPokemonDetail(id: String) async throws -> PokemonResponse {
        let result = await sessionManager.request("\(baseUrl)/pokemon/\(id)").serializingDecodable(PokemonResponse.self, decoder: JSONSnakeCase.decoder()).result
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            debugPrint(error)
            throw error
        }
    }
    
    func getSpecies(id: String) async throws -> PokemonSpeciesResponse {
        let result = await sessionManager.request("\(baseUrl)/pokemon-species/\(id)").serializingDecodable(PokemonSpeciesResponse.self, decoder: JSONSnakeCase.decoder()).result
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            debugPrint(error)
            throw error
        }
    }
    
    func getEvolutions(evolutionId: String) async throws -> EvolutionChainResponse {
        let result = await sessionManager.request("\(baseUrl)/evolution-chain/\(evolutionId)").serializingDecodable(EvolutionChainResponse.self, decoder: JSONSnakeCase.decoder()).result
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            debugPrint(error)
            throw error
        }
    }
}
