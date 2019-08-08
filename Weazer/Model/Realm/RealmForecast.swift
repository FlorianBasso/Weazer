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
    
    override func updatePropertiesFromDatabase<T>(to model: T) where T : Model {
        super.updatePropertiesFromDatabase(to: model)
        guard let forecast = model as? Forecast else { return }
        forecast.cityName = self.cityName
        forecast.weather =  self.weather?.entity(forType: Weather.self)
        forecast.sunInfo = self.sunInfo?.entity(forType: SunInfo.self)
        forecast.wind = self.wind?.entity(forType: Wind.self)
        forecast.forecastMainInfo = self.forecastMainInfo?.entity(forType: ForecastMainInfo.self)
        forecast.forUserPosition = self.forUserPosition
    }
    override func updatePropertiesToDatabase<T>(from model: T) where T : Model {
        super.updatePropertiesToDatabase(from: model)
       
        guard let forecast = model as? Forecast else { return }
        self.cityName = forecast.cityName
        self.forUserPosition = forecast.forUserPosition
        
        // Weather
        if let weather = forecast.weather {
            let realmWeather = RealmWeather()
            realmWeather.updatePropertiesToDatabase(from: weather)
            self.weather = realmWeather
        }
        
        // Sun Info
        if let sunInfo = forecast.sunInfo {
            let realmSunInfo = RealmSunInfo()
            realmSunInfo.updatePropertiesToDatabase(from: sunInfo)
            self.sunInfo = realmSunInfo
        }
        
        // Wind
        if let wind = forecast.wind {
            let realmWind = RealmWind()
            realmWind.updatePropertiesToDatabase(from: wind)
            self.wind = realmWind
        }
        
        // Forecast Main Info
        if let forecastMainInfo = forecast.forecastMainInfo {
            let realmForecastMainInfo = RealmForecastMainInfo()
            realmForecastMainInfo.updatePropertiesToDatabase(from: forecastMainInfo)
            self.forecastMainInfo = realmForecastMainInfo
        }
    }
    
}
