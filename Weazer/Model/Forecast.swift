//
//  Forecast.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

class Forecast: Model {
    
    // MARK: - Properties
    var cityName: String?
    var weather: Weather?
    var sunInfo: SunInfo?
    var wind: Wind?
    var forecastMainInfo: ForecastMainInfo?
    var forUserPosition = false
    
    struct Constants {
        static let name = "name"
        static let weather = "weather"
        static let sys = "sys"
        static let wind = "wind"
        static let main = "main"
    }

    // MARK: - Parsing
    
    override open func parse(data: [AnyHashable : Any]) {
        super.parse(data: data)
        
        // Name
        if let name = data[Constants.name] as? String {
            self.cityName = name
        }
        
        // Weather
        if let weatherArray = data[Constants.weather] as? [[String: Any]],
            let weatherDict = weatherArray.first {
            self.weather = Weather(data: weatherDict)
        }
        
        // SunInfo
        if let sunDict = data[Constants.sys] as? [String:Any] {
            self.sunInfo = SunInfo(data: sunDict)            
        }
        
        // Wind
        if let windDict = data[Constants.wind] as? [String:Any] {
            self.wind = Wind(data: windDict)
        }
        
        // Forecast Main Info
        if let forecastMainDict = data[Constants.main] as? [String:Any] {
            self.forecastMainInfo = ForecastMainInfo(data: forecastMainDict)
        }
        
    }
    
}
