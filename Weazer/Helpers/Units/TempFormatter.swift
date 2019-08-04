//
//  TempFormatter.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

struct TempFormatter {
    
    static func tempText(unitFormatIsImperial: Bool, temp: Double) -> String {
        
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
        
        let tempFahrenheit = Measurement<Dimension>(value: temp,
                                          unit: UnitTemperature.fahrenheit)
        
        if unitFormatIsImperial {
            return measurementFormatter.string(from: tempFahrenheit)
        } else {
            return measurementFormatter.string(from: tempFahrenheit.converted(to: UnitTemperature.celsius))
        }
    }
}
