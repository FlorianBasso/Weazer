//
//  ForecastTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class ForecastTests: TestCase {

    // MARK: - forUserPosition
    func test_forUserPosition_shouldReturnFalse() {
        // Given
        let forecast = Forecast()
        
        // When
        let forUserPosition = forecast.forUserPosition
        
        // Then
        XCTAssertFalse(forUserPosition)
    }
    
    // MARK: - name
    func test_name_shouldReturnCorrectText() {
        // Given & When
        let name = Forecast.Constants.name
        
        // Then
        XCTAssertEqual(name, "name")
    }
    
    // MARK: - weather
    func test_weather_shouldReturnCorrectText() {
        // Given & When
        let weather = Forecast.Constants.weather
        
        // Then
        XCTAssertEqual(weather, "weather")
    }
    
    // MARK: - sys
    func test_sys_shouldReturnCorrectText() {
        // Given & When
        let sys = Forecast.Constants.sys
        
        // Then
        XCTAssertEqual(sys, "sys")
    }
    
    // MARK: - wind
    func test_wind_shouldReturnCorrectText() {
        // Given & When
        let wind = Forecast.Constants.wind
        
        // Then
        XCTAssertEqual(wind, "wind")
    }
    
    // MARK: - main
    func test_main_shouldReturnCorrectText() {
        // Given & When
        let main = Forecast.Constants.main
        
        // Then
        XCTAssertEqual(main, "main")
    }
    
    
    // MARK: - parse
    func test_parse_shouldSetProperties_whenDataIsCorrect() {
        // Given
        let forecast = Forecast()
        let name = "Paris"
        
        let weatherDict = [[Weather.Constants.icon: "icon"]]
        let sunDict = [SunInfo.Constants.sunrise: 12453]
        let windDict = [Wind.Constants.speed: 125.3]
        let infoDict = [ForecastMainInfo.Constants.temp: 45.3]
        
        
        let data: [AnyHashable: Any] = [Forecast.Constants.name: name,
                                        Forecast.Constants.weather: weatherDict,
                                        Forecast.Constants.sys: sunDict,
                                        Forecast.Constants.wind: windDict,
                                        Forecast.Constants.main: infoDict]
        
        // When
        forecast.parse(data: data)
        
        // Then
        XCTAssertEqual(forecast.cityName, name)
        XCTAssertNotNil(forecast.weather)
        XCTAssertNotNil(forecast.sunInfo)
        XCTAssertNotNil(forecast.wind)
        XCTAssertNotNil(forecast.forecastMainInfo)
    }
    
    func test_parse_shouldNotSetProperties_whenDataIsNotCorrect() {
        // Given
        let forecast = Forecast()
        let data: [AnyHashable: Any] = ["wrongKey": "la"]
        
        // When
        forecast.parse(data: data)
        
        // Then
        XCTAssertNil(forecast.cityName)
        XCTAssertNil(forecast.weather)
        XCTAssertNil(forecast.sunInfo)
        XCTAssertNil(forecast.wind)
        XCTAssertNil(forecast.forecastMainInfo)
    }
}
