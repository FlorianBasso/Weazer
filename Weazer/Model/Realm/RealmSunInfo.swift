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
    
    override func updatePropertiesFromDatabase<T>(to model: T) where T : Model {
        super.updatePropertiesFromDatabase(to: model)
        guard let sunInfo = model as? SunInfo else { return }
        sunInfo.sunset = self.sunsetDate
        sunInfo.sunrise = self.sunriseDate
        sunInfo.id = self.id
    }
    
    override func updatePropertiesToDatabase<T>(from model: T) where T : Model {
        super.updatePropertiesToDatabase(from: model)
        guard let sunInfo = model as? SunInfo else { return }
        self.sunsetDate = sunInfo.sunset
        self.sunriseDate = sunInfo.sunrise
        self.id = sunInfo.id ?? 0
    }
    
}
