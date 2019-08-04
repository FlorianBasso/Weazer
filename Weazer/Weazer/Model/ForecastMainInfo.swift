//
//  ForecastMainInfo.swift
//  Weazer
//
//  Created by Florian Basso on 12/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

class ForecastMainInfo: Model {
    
    var temperature: Double?
    var temperatureMin: Double?
    var temperatureMax: Double?
    var pressure: Double?
    var humidity: Int?
    
    struct Constants {
        static let temp = "temp"
        static let pressure = "pressure"
        static let humidity = "humidity"
        static let tempMin = "temp_min"
        static let tempMax = "temp_max"
    }
    
    // MARK: - Parsing
    
    override open func parse(data: [AnyHashable : Any]) {
        super.parse(data: data)
        
        // Temperature
        if let temperature = data[Constants.temp] as? Double {
            self.temperature = temperature
        }
        
        // Temperature Min
        if let tempMin = data[Constants.tempMin] as? Double {
            self.temperatureMin = tempMin
        }
        
        // Temperature Max
        if let tempMax = data[Constants.tempMax] as? Double {
            self.temperatureMax = tempMax
        }
        
        // Pressure
        if let pressure = data[Constants.pressure] as? Double {
            self.pressure = pressure
        }
        
        // Humidity
        if let humidity = data[Constants.humidity] as? Int {
            self.humidity = humidity
        }        
    }
    
    override func remoteKey(inRepresentation representation: [AnyHashable: Any]) -> Int {
        guard let allForecastMainInfo = AppEnvironment.shared().database?.getAll(type: ForecastMainInfo.self) else {
            return 0
        }
        
        return allForecastMainInfo.count + 1
    }
}
