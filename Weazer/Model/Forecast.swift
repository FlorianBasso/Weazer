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
    var id: Int?
    var name: String?
    var weathers: [Weather]?
    var sunInfo: SunInfo?
    var wind: Wind?
    var forecastMainInfo: ForecastMainInfo?
    var forUserPosition = false
            
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case weathers = "weather"
        case sunInfo = "sys"
        case wind
        case forecastMainInfo = "main"
    }
}

extension Forecast {
    static func ==(lhs: Forecast, rhs: Forecast) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&            
            lhs.sunInfo == rhs.sunInfo &&
            lhs.wind == rhs.wind &&
            lhs.forecastMainInfo == rhs.forecastMainInfo &&
            lhs.forUserPosition == rhs.forUserPosition
    }
}



