//
//  RealmWeatherTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class RealmWeatherTests: TestCase {
    
    // MARK: - updatePropertiesFromDatabase
    func test_updatePropertiesFromDatabase_shouldUpdatePropertiesToWeather() {
        // Given
        let realmWeather = RealmWeather()
        let remoteKey = 2
        realmWeather.remoteKey = remoteKey
        realmWeather.headline = "headline"
        realmWeather.descriptionText = "bla"
        realmWeather.iconName = "bli"
        
        let weather = Weather()
        
        // When
        realmWeather.updatePropertiesFromDatabase(to: weather)
        
        // Then
        XCTAssertEqual(weather.remoteKey, realmWeather.remoteKey)
        XCTAssertEqual(weather.headline, realmWeather.headline)
        XCTAssertEqual(weather.descriptionText, realmWeather.descriptionText)
        XCTAssertEqual(weather.iconName, realmWeather.iconName)
    }
    
    // MARK: - updatePropertiesToDatabase
    func test_updatePropertiesToDatabase_shouldUpdatePropertiesToRealmWeather() {
        // Given
        let realmWeather = RealmWeather()
        let weather = Weather()
        let remoteKey = 2
        weather.remoteKey = remoteKey
        weather.headline = "name"
        weather.descriptionText = "bla"
        weather.iconName = "bli"
        
        // When
        realmWeather.updatePropertiesToDatabase(from: weather)
        
        // Then        
        XCTAssertEqual(weather.remoteKey, realmWeather.remoteKey)
        XCTAssertEqual(weather.headline, realmWeather.headline)
        XCTAssertEqual(weather.descriptionText, realmWeather.descriptionText)
        XCTAssertEqual(weather.iconName, realmWeather.iconName)
    }
    
}
