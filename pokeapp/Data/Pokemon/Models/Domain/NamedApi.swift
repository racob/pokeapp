//
//  NamedApi.swift
//  pokeapp
//
//  Created by MAC-097419 on 08/12/23.
//

import Foundation
import RealmSwift

class NamedApi: Object, Identifiable {
    @Persisted var name: String
    @Persisted var url: String
}

extension NamedApi {
    var id: String {
        let url = URL(string: self.url)!
        return url.lastPathComponent
    }
    
    var imageUrl: URL {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")!
    }
}
