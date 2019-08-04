//
//  RealmSunInfo.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

class RealmSunInfo: RealmModel {
    
    // MARK: - Properties
    
    dynamic var sunriseDate: Date?
    dynamic var sunsetDate: Date?
    
    // MARK: - YMMRealmObject
    
    override var modelToUpdate: Model {
        return SunInfo()
    }
    
    override func updateProperties(to model: Model) {
        super.updateProperties(to: model)
        
        guard let sunInfo = model as? SunInfo else { return }
        sunInfo.sunsetDate = self.sunsetDate
        sunInfo.sunriseDate = self.sunriseDate
    }
    
    override func configure(model: Model) {
        super.configure(model: model)
        
        guard let sunInfo = model as? SunInfo else { return }
        self.sunsetDate = sunInfo.sunsetDate
        self.sunriseDate = sunInfo.sunriseDate
    }
    
}
