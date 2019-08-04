//
//  SunInfoTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class SunInfoTests: TestCase {

    // MARK: - sunrise
    func test_sunrise_shouldReturnCorrectText() {
        // Given & When
        let sunrise = SunInfo.Constants.sunrise
        
        // Then
        XCTAssertEqual(sunrise, "sunrise")
    }
    
    // MARK: - sunset
    func test_sunset_shouldReturnCorrectText() {
        // Given & When
        let sunset = SunInfo.Constants.sunset
        
        // Then
        XCTAssertEqual(sunset, "sunset")
    }
    
    // MARK: - parse
    func test_parse_shouldSetProperties_whenDataIsCorrect() {
        // Given
        let sunInfo = SunInfo()
        let sunrise: Int64 = 349324
        let sunset: Int64 = 3309539
        let data = [SunInfo.Constants.sunrise: sunrise,
                    SunInfo.Constants.sunset: sunset]
        
        // When
        sunInfo.parse(data: data)
        
        // Then
        XCTAssertEqual(sunInfo.sunsetDate!.timeIntervalSince1970, TimeInterval(sunset))
        XCTAssertEqual(sunInfo.sunriseDate!.timeIntervalSince1970, TimeInterval(sunrise))
    }
    
    func test_parse_shouldNotSetProperties_whenDataIsNotCorrect() {
        // Given
        let sunInfo = SunInfo()
        let data = ["wrongKey": "la"]
        
        // When
        sunInfo.parse(data: data)
        
        // Then
        XCTAssertNil(sunInfo.sunriseDate)
        XCTAssertNil(sunInfo.sunsetDate)
    }

}
