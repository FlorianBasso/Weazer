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
        return #keyPath(RealmModel.remoteKey)
    }
    
    // MARK: - YMMRealmObject
    
    @objc dynamic var remoteKey: Int = 0    
    
    func entity<T: Model>(forType: T.Type) -> T {
        let model = T.init()
        self.updatePropertiesFromDatabase(to: model)
        return model
    }
    
    func updatePropertiesToDatabase<T: Model>(from model: T) {
        self.remoteKey = model.remoteKey
    }
    
    func updatePropertiesFromDatabase<T: Model>(to model: T) {
        model.remoteKey = self.remoteKey
    }
    
}
