//
//  RealmForecastMainInfo.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

class RealmForecastMainInfo: RealmModel {
    
    // MARK: - Properties
    dynamic var temperature: Double = 0
    dynamic var temperatureMin: Double = 0
    dynamic var temperatureMax: Double = 0
    dynamic var pressure: Double = 0
    dynamic var humidity: Int = 0
    
    // MARK: - YMMRealmObject
    
    override var modelToUpdate: Model {
        return ForecastMainInfo()
    }
    
    override func updateProperties(to model: Model) {
        super.updateProperties(to: model)
        
        guard let forecastMainInfo = model as? ForecastMainInfo else { return }                
        forecastMainInfo.remoteKey = self.remoteKey
        forecastMainInfo.temperature = self.temperature
        forecastMainInfo.temperatureMin = self.temperatureMin
        forecastMainInfo.temperatureMax = self.temperatureMax
        forecastMainInfo.pressure = self.pressure
        forecastMainInfo.humidity = self.humidity
    }
    
    override func configure(model: Model) {
        super.configure(model: model)
        
        guard let forecastMainInfo = model as? ForecastMainInfo else { return }                
        self.temperature = forecastMainInfo.temperature ?? 0
        self.temperatureMin = forecastMainInfo.temperatureMin ?? 0
        self.temperatureMax = forecastMainInfo.temperatureMax ?? 0
        self.pressure = forecastMainInfo.pressure ?? 0
        self.humidity = forecastMainInfo.humidity ?? 0
    }
    
}
