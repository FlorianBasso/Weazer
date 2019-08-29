//
//  RealmForecastTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class RealmForecastTests: TestCase {
    
    // MARK: - updatePropertiesFromDatabase
    func test_updatePropertiesFromDatabase_shouldUpdatePropertiesToRepo() {
        // Given
        let realmForecast = RealmForecast()
        let remoteKey = 2
        realmForecast.id = remoteKey
        realmForecast.name = "name"
        
        let realmWeather = RealmWeather()
        realmForecast.weathers.append(realmWeather)
        
        let realmSunInfo = RealmSunInfo()
        realmForecast.sunInfo = realmSunInfo
        
        let realmWind = RealmWind()
        realmForecast.wind = realmWind
        
        let realmForecastMainInfo = RealmForecastMainInfo()
        realmForecast.forecastMainInfo = realmForecastMainInfo
        
        let forUserPosition = false
        realmForecast.forUserPosition = forUserPosition
        
    
        let forecast = Forecast()
        
        // When
        realmForecast.updatePropertiesFromDatabase(to: forecast)
        
        // Then
        XCTAssertEqual(forecast.id, realmForecast.id)
        XCTAssertEqual(forecast.name, realmForecast.name)
        XCTAssertEqual(forecast.weathers?.first, realmForecast.weathers.first?.entity(forType: Weather.self))
        XCTAssertEqual(forecast.sunInfo, realmForecast.sunInfo?.entity(forType: SunInfo.self))
        XCTAssertEqual(forecast.wind, realmForecast.wind?.entity(forType: Wind.self))
        XCTAssertEqual(forecast.forecastMainInfo, realmForecast.forecastMainInfo?.entity(forType: ForecastMainInfo.self))
        XCTAssertEqual(forecast.forUserPosition, realmForecast.forUserPosition)
    }
    
    // MARK: - updatePropertiesToDatabase
    func test_updatePropertiesToDatabase_shouldUpdatePropertiesToRealm() {
        // Given
        let realmForecast = RealmForecast()
        let forecast = Forecast()
        let remoteKey = 2
        forecast.id = remoteKey
        forecast.name = "name"
        
        let weather = Weather()
        weather.id = remoteKey
        forecast.weathers = [weather]
        
        let sunInfo = SunInfo()
        sunInfo.id = remoteKey
        forecast.sunInfo = sunInfo
        
        let wind = Wind()
        wind.id = remoteKey
        wind.speed = 0
        wind.deg = 0
        forecast.wind = wind
        
        let forecastMainInfo = ForecastMainInfo()
        forecastMainInfo.id = remoteKey
        forecastMainInfo.temp  = 0
        forecastMainInfo.tempMin = 0
        forecastMainInfo.tempMax = 0
        forecastMainInfo.pressure = 0
        forecastMainInfo.humidity = 0
        forecast.forecastMainInfo = forecastMainInfo
        
        forecast.forUserPosition = false
        
        // When
        realmForecast.updatePropertiesToDatabase(from: forecast)
        
        // Then        
        XCTAssertEqual(forecast.id, realmForecast.id)
        XCTAssertEqual(forecast.name, realmForecast.name)
        XCTAssertEqual(forecast.weathers!.first, realmForecast.weathers.first!.entity(forType: Weather.self))
        XCTAssertEqual(forecast.sunInfo, realmForecast.sunInfo!.entity(forType: SunInfo.self))
        XCTAssertEqual(forecast.wind, realmForecast.wind!.entity(forType: Wind.self))
        XCTAssertEqual(forecast.forecastMainInfo, realmForecast.forecastMainInfo!.entity(forType: ForecastMainInfo.self))
        XCTAssertEqual(forecast.forUserPosition, realmForecast.forUserPosition)
        
    }
    
}
