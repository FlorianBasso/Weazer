//
//  ForecastMainInfo.swift
//  Weazer
//
//  Created by Florian Basso on 12/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

class ForecastMainInfo: Model {
    
    // Use
    // encoder.keyEncodingStrategy = .convertToSnakeCase
    // decoder.keyDecodingStrategy = .convertFromSnakeCase
    //
    var id: Int?
    var temp: Double?
    var tempMin: Double?
    var tempMax: Double?
    var pressure: Double?
    var humidity: Int?
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case tempMin
        case tempMax
        case pressure
        case humidity
    }
    
}

extension ForecastMainInfo {
    static func ==(lhs: ForecastMainInfo, rhs: ForecastMainInfo) -> Bool {
        return lhs.id == rhs.id &&
            lhs.temp == rhs.temp &&
            lhs.tempMin == rhs.tempMin &&
            lhs.tempMax == rhs.tempMax &&
            lhs.pressure == rhs.pressure &&
            lhs.humidity == rhs.humidity    
    }
}
