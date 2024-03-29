//
//  ForecastDetailVM.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

class ForecastDetailVM: TableViewModel {
    
    // MARK: - Properties
    let forecast: Forecast
    var unitFormatIsImperial: Bool
    
    override var title: String? {
        get {
            return self.forecast.name
        }
        set {}
    }
    
    // MARK: - Init
    init(forecast: Forecast, unitFormatIsImperial: Bool) {
        self.forecast = forecast
        self.unitFormatIsImperial = unitFormatIsImperial
    }
    
    // MARK: - Load
    override func load() {
        super.load()                
        self.handleSuccess()
    }
    
    override func loadSections() {
        super.loadSections()
        self.sections.removeAll()
        
        let section = TableSection()
        
        // Forecast
        let forecastCVM = ForecastCellViewModel(forecast: self.forecast,
                                            unitFormatIsImperial: self.unitFormatIsImperial)
        section.items.append(forecastCVM)
        
        // Weather
        if let firstWeatherDescription = self.forecast.weathers?.first?.description {
            let title = NSLocalizedString("weather.title", comment: "")
            let weatherCVM = DetailInfoCellViewModel(title: title, info: firstWeatherDescription.capitalized)
            section.items.append(weatherCVM)
        }
        
        
        // Sun Info
        if let sunriseDate = self.forecast.sunInfo?.sunrise {
            let sunriseTitle = NSLocalizedString("sunrise.title", comment: "")
            let sunriseTime = TimeFormatter.time(from: sunriseDate)
            let sunriseCVM = DetailInfoCellViewModel(title: sunriseTitle, info: sunriseTime)
            section.items.append(sunriseCVM)
        }
        
        if let sunsetDate = self.forecast.sunInfo?.sunset {
            let sunsetTitle = NSLocalizedString("sunset.title", comment: "")
            let sunsetTime = TimeFormatter.time(from: sunsetDate)
            let sunsetCVM = DetailInfoCellViewModel(title: sunsetTitle, info: sunsetTime)
            section.items.append(sunsetCVM)
        }
        
        
        // Wind
        if let speed = self.forecast.wind?.speed {
            let windTitle = NSLocalizedString("wind.title", comment: "")
            let speedText = SpeedFormatter.speedText(unitFormatIsImperial: self.unitFormatIsImperial,
                                                     speed: speed)
            let windCVM = DetailInfoCellViewModel(title: windTitle, info: speedText)
            section.items.append(windCVM)
        }
        
        
        // Main Info
        let forecastMainInfo = self.forecast.forecastMainInfo
            
        if let tempMin = forecastMainInfo?.tempMin {
            let tempMinTitle = NSLocalizedString("temp.min.title", comment: "")
            let tempMinText = TempFormatter.tempText(unitFormatIsImperial: self.unitFormatIsImperial, temp: tempMin)
            let tempMinCVM = DetailInfoCellViewModel(title: tempMinTitle, info: tempMinText)
            section.items.append(tempMinCVM)
        }
        
        if let tempMax = forecastMainInfo?.tempMax {
            let tempMaxTitle = NSLocalizedString("temp.max.title", comment: "")
            let tempMaxText = TempFormatter.tempText(unitFormatIsImperial: self.unitFormatIsImperial, temp: tempMax)
            let tempMaxCVM = DetailInfoCellViewModel(title: tempMaxTitle, info: tempMaxText)
            section.items.append(tempMaxCVM)
        }
        
        
        if let humidity = forecastMainInfo?.humidity {
            let humidityTitle = NSLocalizedString("humidity.title", comment: "")
            let humidityText = "\(humidity)%"
            let humidityCVM = DetailInfoCellViewModel(title: humidityTitle, info: humidityText)
            section.items.append(humidityCVM)
        }
        
        self.sections.append(section)
    }
    
}
