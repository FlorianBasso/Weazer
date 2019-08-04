//
//  SunInfo.swift
//  Weazer
//
//  Created by Florian Basso on 12/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

class SunInfo: Model {
    
    var sunriseDate: Date?
    var sunsetDate: Date?
    
    struct Constants {
        static let sunrise = "sunrise"
        static let sunset = "sunset"
        
    }
    
    // MARK: - Parsing
    
    override open func parse(data: [AnyHashable : Any]) {
        super.parse(data: data)
        
        // Sunrise
        if let sunriseUTC = data[Constants.sunrise] as? Int64 {
            self.sunriseDate = Date(timeIntervalSince1970: TimeInterval(sunriseUTC))
        }
        
        // Sunset
        if let sunsetUTC = data[Constants.sunset] as? Int64 {
            self.sunsetDate = Date(timeIntervalSince1970: TimeInterval(sunsetUTC))
        }
        
    }
}
