//
//  RealmModel.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class RealmModel: Object {
    
    // MARK: - Object
    
    override class func primaryKey() -> String? {
        return #keyPath(RealmModel.id)
    }
    
    // MARK: - YMMRealmObject
    
    @objc dynamic var id: Int = 0
    
    func entity<T: Model>(forType: T.Type) -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970  
        
        let data = try! JSONSerialization.data(withJSONObject: [:], options: [])
        let model = try! decoder.decode(T.self, from: data)
        self.updatePropertiesFromDatabase(to: model)
        return model
    }
    
    func updatePropertiesToDatabase<T: Model>(from model: T) {
        // Override in subclasses
    }
    
    func updatePropertiesFromDatabase<T: Model>(to model: T) {
        // Override in subclasses
    }
    
}
