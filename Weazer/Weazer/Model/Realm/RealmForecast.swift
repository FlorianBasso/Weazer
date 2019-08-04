//
//  RealmForecast.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import RealmSwift

class RealmForecast: RealmModel {
    
    // MARK: - Properties
    
    dynamic var cityName: String?
    dynamic var weather: RealmWeather?
    dynamic var sunInfo: RealmSunInfo?
    dynamic var wind: RealmWind?
    dynamic var forecastMainInfo: RealmForecastMainInfo?
    dynamic var forUserPosition: Bool = false
    
    // MARK: - YMMRealmObject
    
    override var modelToUpdate: Model {
        return Forecast()
    }
    
    override func updateProperties(to model: Model) {
        super.updateProperties(to: model)
        
        guard let forecast = model as? Forecast else { return }
        forecast.cityName = self.cityName
        forecast.weather = self.weather?.entity as? Weather
        forecast.sunInfo = self.sunInfo?.entity as? SunInfo
        forecast.wind = self.wind?.entity as? Wind
        forecast.forecastMainInfo = self.forecastMainInfo?.entity as? ForecastMainInfo
        forecast.forUserPosition = self.forUserPosition
    }
    
    override func configure(model: Model) {
        super.configure(model: model)
        
        guard let forecast = model as? Forecast else { return }
        self.cityName = forecast.cityName
        self.forUserPosition = forecast.forUserPosition
        
        // Weather
        if let weather = forecast.weather {
            let realmWeather = RealmWeather()
            realmWeather.configure(model: weather)
            self.weather = realmWeather
        }
        
        // Sun Info
        if let sunInfo = forecast.sunInfo {
            let realmSunInfo = RealmSunInfo()
            realmSunInfo.configure(model: sunInfo)
            self.sunInfo = realmSunInfo
        }
        
        // Wind
        if let wind = forecast.wind {
            let realmWind = RealmWind()
            realmWind.configure(model: wind)
            self.wind = realmWind
        }
        
        // Forecast Main Info
        if let forecastMainInfo = forecast.forecastMainInfo {
            let realmForecastMainInfo = RealmForecastMainInfo()
            realmForecastMainInfo.configure(model: forecastMainInfo)
            self.forecastMainInfo = realmForecastMainInfo
        }
        
    }
    
}
