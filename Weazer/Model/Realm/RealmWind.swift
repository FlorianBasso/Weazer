//
//  RealmWind.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

class RealmWind: RealmModel {
    
    // MARK: - Properties
    dynamic var speed: Double = 0
    dynamic var degree: Int = 0
    
    // MARK: - YMMRealmObject
    
    override func updatePropertiesToDatabase<T>(from model: T) where T : Model {
        super.updatePropertiesToDatabase(from: model)
        guard let wind = model as? Wind else { return }
        
        self.id = wind.id ?? 0
        
        if self.id == 0, let result = AppEnvironment.shared().database?.getAll(type: Wind.self) {
            switch result {
            case .success(let allWind):
                self.id = allWind.count + 1
            default:
                self.id = 0
            }
        }
        
        self.speed = wind.speed ?? 0
        self.degree = wind.deg ?? 0
    }
        
    override func updatePropertiesFromDatabase<T>(to model: T) where T : Model {
        super.updatePropertiesFromDatabase(to: model)
        guard let wind = model as? Wind else { return }                
        wind.id = self.id
        wind.speed = self.speed
        wind.deg = self.degree
    }
    
}
