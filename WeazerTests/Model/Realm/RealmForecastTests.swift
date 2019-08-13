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
        realmForecast.remoteKey = remoteKey
        realmForecast.cityName = "name"
        
        let realmWeather = RealmWeather()
        realmForecast.weather = realmWeather
        
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
        XCTAssertEqual(forecast.remoteKey, realmForecast.remoteKey)
        XCTAssertEqual(forecast.cityName, realmForecast.cityName)
        XCTAssertEqual(forecast.weather, realmForecast.weather?.entity(forType: Weather.self))
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
        forecast.remoteKey = remoteKey
        forecast.cityName = "name"
        
        let weather = Weather()
        forecast.weather = weather
        
        let sunInfo = SunInfo()
        forecast.sunInfo = sunInfo
        
        let wind = Wind()
        forecast.wind = wind
        
        let forecastMainInfo = ForecastMainInfo()
        forecast.forecastMainInfo = forecastMainInfo
        
        forecast.forUserPosition = false
        
        // When
        realmForecast.updatePropertiesToDatabase(from: forecast)
        
        // Then        
        XCTAssertEqual(forecast.remoteKey, realmForecast.remoteKey)
        XCTAssertEqual(forecast.cityName, realmForecast.cityName)
        XCTAssertEqual(forecast.weather, realmForecast.weather?.entity(forType: Weather.self))
        XCTAssertEqual(forecast.sunInfo, realmForecast.sunInfo?.entity(forType: SunInfo.self))
        XCTAssertEqual(forecast.wind, realmForecast.wind?.entity(forType: Wind.self))
        XCTAssertEqual(forecast.forecastMainInfo, realmForecast.forecastMainInfo?.entity(forType: ForecastMainInfo.self))
        XCTAssertEqual(forecast.forUserPosition, realmForecast.forUserPosition)
        
    }
    
}
