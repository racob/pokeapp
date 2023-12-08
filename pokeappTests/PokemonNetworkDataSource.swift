//
//  PokemonNetworkDataSource.swift
//  PokemonNetworkDataSource
//
//  Created by MAC-097419 on 07/12/23.
//

import XCTest
import Mocker
import Alamofire
@testable import pokeapp

final class PokemonNetworkDataSourceTests: XCTestCase {
    private let baseUrl = "https://pokeapi.co/api/v2"
    private var sut: PokemonNetworkDataSource?
    
    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = Session(configuration: configuration)
        sut = PokemonNetworkDataSource(sessionManager: sessionManager)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testGetPokemon() async {
        let endpoint = URL(string: "\(baseUrl)/pokemon?offset=0")!
        
        let mockedData = try! JSONEncoder().encode(ListResponse(results: mockPokemons))
        let mock = Mock(url: endpoint, dataType: .json, statusCode: 200, data: [.get: mockedData])
        mock.register()
        
        do {
            let result = try await sut?.getPokemons()
            XCTAssertEqual(result, mockPokemons)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testGetPokemonDetails() async {
        let endpoint = URL(string: "\(baseUrl)/pokemon/25")!
        
        let mockedData = try! JSONEncoder().encode(mockPokemonDetail)
        let mock = Mock(url: endpoint, dataType: .json, statusCode: 200, data: [.get: mockedData])
        mock.register()
        
        do {
            let result = try await sut?.getPokemonDetail(id: "25")
            XCTAssertEqual(result, mockPokemonDetail)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testGetPokemonSpecies() async {
        let endpoint = URL(string: "\(baseUrl)/pokemon-species/25")!
        
        let mockedData = try! JSONEncoder().encode(mockSpecies)
        let mock = Mock(url: endpoint, dataType: .json, statusCode: 200, data: [.get: mockedData])
        mock.register()
        
        do {
            let result = try await sut?.getSpecies(id: "25")
            XCTAssertEqual(result, mockSpecies)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testGetPokemonEvolution() async {
        let endpoint = URL(string: "\(baseUrl)/evolution-chain/10")!
        
        let mockedData = try! JSONEncoder().encode(mockEvolutions)
        let mock = Mock(url: endpoint, dataType: .json, statusCode: 200, data: [.get: mockedData])
        mock.register()
        
        do {
            let result = try await sut?.getEvolutions(evolutionId: "10")
            XCTAssertEqual(result, mockEvolutions)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
}

fileprivate let mockPokemons = [NamedApiResponse(name: "pikachu", url: URL(string: "https://pokeapi.co/api/v2")!)]

fileprivate let mockPokemonDetail = Pokemon(
    id: 25,
    name: "pikachu",
    height: 1,
    weight: 2,
    stats: [],
    types: []
)

fileprivate let mockSpecies = PokemonSpecies(
    id: 25,
    evolutionChain: PokemonSpecies.EvolutionChain(url: URL(string: "https://pokeapi.co/api/v2")!)
)

fileprivate let mockEvolutions = EvolutionChain(
    id: 1,
    chain: ChainLink(
        species: NamedApiResponse(
            name: "pikachu",
            url: URL(string: "https://pokeapi.co/api/v2")!
        ),
        evolvesTo: [
            ChainLink(
                species: NamedApiResponse(
                    name: "raichu",
                    url: URL(string: "https://pokeapi.co/api/v2")!
                ),
                evolvesTo: []
            )
        ]
    )
)
