//
//  WeatherTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class WeatherTests: TestCase {
    
    // MARK: - main
    func test_main_shouldReturnCorrectText() {
        // Given & When
        let main = Weather.Constants.main
        
        // Then
        XCTAssertEqual(main, "main")
    }
    
    // MARK: - description
    func test_description_shouldReturnCorrectText() {
        // Given & When
        let description = Weather.Constants.description
        
        // Then
        XCTAssertEqual(description, "description")
    }
    
    // MARK: - icon
    func test_icon_shouldReturnCorrectText() {
        // Given & When
        let icon = Weather.Constants.icon
        
        // Then
        XCTAssertEqual(icon, "icon")
    }
    
    // MARK: - parse
    func test_parse_shouldSetProperties_whenDataIsCorrect() {
        // Given
        let weather = Weather()
        let headline = "headline"
        let descriptionText = "bla"
        let iconName = "icon"
        let data = [Weather.Constants.main: headline,
                    Weather.Constants.description: descriptionText,
                    Weather.Constants.icon: iconName]
        
        // When
        weather.parse(data: data)
        
        // Then
        XCTAssertEqual(weather.headline, headline)
        XCTAssertEqual(weather.descriptionText, descriptionText)
        XCTAssertEqual(weather.iconName, iconName)
    }
    
    func test_parse_shouldNotSetProperties_whenDataIsNotCorrect() {
        // Given
        let weather = Weather()
        let data = ["wrongKey": "la"]
        
        // When
        weather.parse(data: data)
        
        // Then
        XCTAssertNil(weather.headline)
        XCTAssertNil(weather.descriptionText)
        XCTAssertNil(weather.iconName)
    }

}
