//
//  SpeedFormatter.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

struct SpeedFormatter {
           
    static func speedText(unitFormatIsImperial: Bool, speed: Double) -> String {
        
        let measurementFormatter: MeasurementFormatter = {
            let formatter = MeasurementFormatter()
            formatter.unitOptions = .providedUnit
            let numberFormatter = NumberFormatter()
            numberFormatter.minimumIntegerDigits = 1
            numberFormatter.minimumFractionDigits = 0
            numberFormatter.maximumFractionDigits = 0
            formatter.numberFormatter = numberFormatter
            return formatter
        }()
        
        let windSpeed = Measurement<Dimension>(value: speed,
                                               unit: UnitSpeed.milesPerHour)
        
        if unitFormatIsImperial {
            let milePerHour = measurementFormatter.string(from: windSpeed)
            return milePerHour
        } else {
            
            let kmPerHour = measurementFormatter.string(from: windSpeed.converted(to: UnitSpeed.kilometersPerHour))
            return kmPerHour
        }
    }
}
