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
    
    override func updatePropertiesFromDatabase<T>(to model: T) where T : Model {
        super.updatePropertiesFromDatabase(to: model)
        guard let forecastMainInfo = model as? ForecastMainInfo else { return }
        forecastMainInfo.id = self.id
        forecastMainInfo.temp = self.temperature
        forecastMainInfo.tempMin = self.temperatureMin
        forecastMainInfo.tempMax = self.temperatureMax
        forecastMainInfo.pressure = self.pressure
        forecastMainInfo.humidity = self.humidity
    }
    
    override func updatePropertiesToDatabase<T>(from model: T) where T : Model {
        super.updatePropertiesToDatabase(from: model)
        guard let forecastMainInfo = model as? ForecastMainInfo else { return }
        
        self.id = forecastMainInfo.id ?? 0
        
        if self.id == 0,
            let result = AppEnvironment.shared().database?.getAll(type: ForecastMainInfo.self) {
            
            switch result {
            case .success(let allForecastMainInfo):
                self.id = allForecastMainInfo.count + 1
            default:
                self.id = 0
            }
        } 
                
        self.temperature = forecastMainInfo.temp ?? 0
        self.temperatureMin = forecastMainInfo.tempMin ?? 0
        self.temperatureMax = forecastMainInfo.tempMax ?? 0
        self.pressure = forecastMainInfo.pressure ?? 0
        self.humidity = forecastMainInfo.humidity ?? 0
    }
    
}
