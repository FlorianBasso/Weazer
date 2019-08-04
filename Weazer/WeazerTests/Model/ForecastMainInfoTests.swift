//
//  ForecastMainInfoTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class ForecastMainInfoTests: TestCase {

    // MARK: - temp
    func test_temp_shouldReturnCorrectText() {
        // Given & When
        let temp = ForecastMainInfo.Constants.temp
        
        // Then
        XCTAssertEqual(temp, "temp")
    }
    
    // MARK: - pressure
    func test_pressure_shouldReturnCorrectText() {
        // Given & When
        let pressure = ForecastMainInfo.Constants.pressure
        
        // Then
        XCTAssertEqual(pressure, "pressure")
    }
    
    // MARK: - humidity
    func test_humidity_shouldReturnCorrectText() {
        // Given & When
        let humidity = ForecastMainInfo.Constants.humidity
        
        // Then
        XCTAssertEqual(humidity, "humidity")
    }
    
    // MARK: - tempMin
    func test_tempMin_shouldReturnCorrectText() {
        // Given & When
        let tempMin = ForecastMainInfo.Constants.tempMin
        
        // Then
        XCTAssertEqual(tempMin, "temp_min")
    }
    
    // MARK: - tempMax
    func test_tempMax_shouldReturnCorrectText() {
        // Given & When
        let tempMax = ForecastMainInfo.Constants.tempMax
        
        // Then
        XCTAssertEqual(tempMax, "temp_max")
    }
    
    // MARK: - parse
    func test_parse_shouldSetProperties_whenDataIsCorrect() {
        // Given
        let mainInfo = ForecastMainInfo()
        let temp: Double = 68.3
        let tempMin: Double = 28.3
        let tempMax: Double = 88.3
        let pressure: Double = 188.3
        let humidity = 90
        let data: [String : Any] = [ForecastMainInfo.Constants.temp: temp,
                                    ForecastMainInfo.Constants.tempMin: tempMin,
                                    ForecastMainInfo.Constants.tempMax: tempMax,
                                    ForecastMainInfo.Constants.pressure: pressure,
                                    ForecastMainInfo.Constants.humidity: humidity]
        
        // When
        mainInfo.parse(data: data)
        
        // Then
        XCTAssertEqual(mainInfo.temperature, temp)
        XCTAssertEqual(mainInfo.temperatureMin, tempMin)
        XCTAssertEqual(mainInfo.temperatureMax, tempMax)
        XCTAssertEqual(mainInfo.pressure, pressure)
        XCTAssertEqual(mainInfo.humidity, humidity)
    }
    
    func test_parse_shouldNotSetProperties_whenDataIsNotCorrect() {
        // Given
        let mainInfo = ForecastMainInfo()
        let data = ["wrongKey": "la"]
        
        // When
        mainInfo.parse(data: data)
        
        // Then
        XCTAssertNil(mainInfo.temperature)
        XCTAssertNil(mainInfo.temperatureMin)
        XCTAssertNil(mainInfo.temperatureMax)
        XCTAssertNil(mainInfo.pressure)
        XCTAssertNil(mainInfo.humidity)
    }
    
    // MARK: - remoteKey
    func test_remoteKey_shouldReturnZero_whenNoWindIsStoredInDatabase() {
        // Given
        let mainInfo = ForecastMainInfo()
        
        // When
        let remoteKey = mainInfo.remoteKey(inRepresentation: [:])
        
        // Then
        XCTAssertEqual(remoteKey, 0)
    }
    
    func test_remoteKey_shouldReturnCorrectValue_whenSomeWindIsStoredInDatabase() {
        // Given
        let mainInfo = ForecastMainInfo()
        self.database.mockGetAll = [mainInfo]
        
        // When
        let remoteKey = mainInfo.remoteKey(inRepresentation: [:])
        
        // Then
        XCTAssertEqual(remoteKey, self.database.mockGetAll!.count + 1)
    }

}
