//
//  Array+appendWithoutDuplicate.swift
//  pokeapp
//
//  Created by MAC-097419 on 08/12/23.
//

import Foundation

extension Array where Element: Hashable {
    mutating func appendWithoutDuplicate(_ array: [Element]) {
        var seen = Set<Element>()
        self = (self + array).filter { seen.insert($0).inserted }
    }
}

