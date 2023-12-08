//
//  persistentManager.swift
//  pokeapp
//
//  Created by MAC-097419 on 08/12/23.
//

import Foundation
import RealmSwift

class PersistentManager {
    static let shared = PersistentManager()
    
    private init() {}
    
    func addObject<T: Object>(_ object: T) {
        guard let realm = try? Realm() else { return }
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            debugPrint("Error adding object to Realm: \(error.localizedDescription)")
        }
    }
    
    func fetchObjects<T: Object>(ofType type: T.Type, withQuery query: String? = nil, arguments: [Any]? = nil) -> Results<T>? {
        guard let realm = try? Realm() else { return nil }
        
        let objects = realm.objects(type)
        
        if let query = query, let arguments = arguments {
            return objects.filter(query, arguments)
        } else if let query = query {
            return objects.filter(query)
        } else {
            return objects
        }
    }
}
