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
    
    dynamic var name: String?
    var weathers = List<RealmWeather>()
    dynamic var sunInfo: RealmSunInfo?
    dynamic var wind: RealmWind?
    dynamic var forecastMainInfo: RealmForecastMainInfo?
    dynamic var forUserPosition: Bool = false
            
    // MARK: - YMMRealmObject
    
    override func updatePropertiesFromDatabase<T>(to model: T) where T : Model {
        super.updatePropertiesFromDatabase(to: model)
        guard let forecast = model as? Forecast else { return }
        forecast.name = self.name
        
        if let weather = self.weathers.first?.entity(forType: Weather.self) {
            forecast.weathers =  [weather]
        }
        
        forecast.sunInfo = self.sunInfo?.entity(forType: SunInfo.self)
        forecast.wind = self.wind?.entity(forType: Wind.self)
        forecast.forecastMainInfo = self.forecastMainInfo?.entity(forType: ForecastMainInfo.self)
        forecast.forUserPosition = self.forUserPosition
        forecast.id = self.id
    }
    
    override func updatePropertiesToDatabase<T>(from model: T) where T : Model {
        super.updatePropertiesToDatabase(from: model)
       
        guard let forecast = model as? Forecast else { return }
        
        self.id = forecast.id ?? 0
        self.name = forecast.name
        self.forUserPosition = forecast.forUserPosition
        
        // Weather
        if let firstWeather = forecast.weathers?.first {
            let realmWeather = RealmWeather()
            realmWeather.updatePropertiesToDatabase(from: firstWeather)
            let realmWeathers = List<RealmWeather>()
            realmWeathers.append(realmWeather)
            self.weathers = realmWeathers
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
        if let mainInfo = forecast.forecastMainInfo {
            let realmForecastMainInfo = RealmForecastMainInfo()
            realmForecastMainInfo.updatePropertiesToDatabase(from: mainInfo)
            self.forecastMainInfo = realmForecastMainInfo
        }
        
    }
    
}
