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
        return #keyPath(RealmModel.remoteKeyString)
    }
    
    // MARK: - YMMRealmObject
    
    dynamic var remoteKey = 0
    dynamic var remoteKeyString: String = ""
    
    var modelToUpdate: Model {
        return Model()
    }
    
    dynamic var entity: Model {
        let model = self.modelToUpdate
        self.updateProperties(to: model)
        return model
    }
    
    func updateProperties(to model: Model) {
        model.remoteKey = self.remoteKey
        model.remoteKeyString = self.remoteKeyString
    }
    
    func configure(model: Model) {
        // Overrides in subclasses and stores information from the model
        self.remoteKey = model.remoteKey
        self.configureRemoteKeyString()
    }
    
    func configureRemoteKeyString() {
        if (self.remoteKey != 0) {
            self.remoteKeyString = "\(self.remoteKey)"
        }
    }
    
}
