//
//  JSONDecoder+decode.swift
//  pokeapp
//
//  Created by MAC-097419 on 05/12/23.
//

import Foundation

class JSONSnakeCase {
    static func decoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return decoder
    }
}
