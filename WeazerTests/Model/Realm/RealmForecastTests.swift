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
    
    
    // MARK: - modelToUpdate
    func test_modelToUpdate_shouldReturnARepo() {
        // Given
        let realmModel = RealmForecast()
        
        // When
        let modelToUpdate = realmModel.modelToUpdate
        
        // Then
        XCTAssertNotNil(modelToUpdate)
        XCTAssert(modelToUpdate is Forecast)
    }
    
    // MARK: - updateProperties
    func test_updateProperties_shouldUpdatePropertiesToRepo() {
        // Given
        let realmForecast = RealmForecast()
        let remoteKey = 2
        let remoteKeyString = "\(remoteKey)"
        realmForecast.remoteKey = remoteKey
        realmForecast.remoteKeyString = remoteKeyString
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
        realmForecast.updateProperties(to: forecast)
        
        // Then
        XCTAssertEqual(forecast.remoteKeyString, realmForecast.remoteKeyString)
        XCTAssertEqual(forecast.remoteKey, realmForecast.remoteKey)
        XCTAssertEqual(forecast.cityName, realmForecast.cityName)
        XCTAssertEqual(forecast.weather, realmForecast.weather?.entity as? Weather)
        XCTAssertEqual(forecast.sunInfo, realmForecast.sunInfo?.entity as? SunInfo)
        XCTAssertEqual(forecast.wind, realmForecast.wind?.entity as? Wind)
        XCTAssertEqual(forecast.forecastMainInfo, realmForecast.forecastMainInfo?.entity as? ForecastMainInfo)
        XCTAssertEqual(forecast.forUserPosition, realmForecast.forUserPosition)
    }
    
    // MARK: - configure
    func test_configure_shouldUpdatePropertiesToRealmRepo() {
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
        realmForecast.configure(model: forecast)
        
        // Then
        XCTAssertEqual(realmForecast.remoteKeyString, "\(realmForecast.remoteKey)")
        XCTAssertEqual(forecast.remoteKey, realmForecast.remoteKey)
        XCTAssertEqual(forecast.cityName, realmForecast.cityName)
        XCTAssertEqual(forecast.weather, realmForecast.weather?.entity as? Weather)
        XCTAssertEqual(forecast.sunInfo, realmForecast.sunInfo?.entity as? SunInfo)
        XCTAssertEqual(forecast.wind, realmForecast.wind?.entity as? Wind)
        XCTAssertEqual(forecast.forecastMainInfo, realmForecast.forecastMainInfo?.entity as? ForecastMainInfo)
        XCTAssertEqual(forecast.forUserPosition, realmForecast.forUserPosition)
        
    }
    
}
