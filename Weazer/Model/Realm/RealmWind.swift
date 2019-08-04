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
    
    override var modelToUpdate: Model {
        return Wind()
    }
    
    override func updateProperties(to model: Model) {
        super.updateProperties(to: model)
        
        guard let wind = model as? Wind else { return }
        wind.speed = self.speed
        wind.degree = self.degree
    }
    
    override func configure(model: Model) {
        super.configure(model: model)
        
        guard let wind = model as? Wind else { return }
        self.speed = wind.speed ?? 0
        self.degree = wind.degree ?? 0
    }
    
}
