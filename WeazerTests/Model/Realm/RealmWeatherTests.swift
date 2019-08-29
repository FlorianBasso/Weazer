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
        realmWeather.id = remoteKey
        realmWeather.headline = "headline"
        realmWeather.descriptionText = "bla"
        realmWeather.iconName = "bli"
        
        let weather = Weather()
        
        // When
        realmWeather.updatePropertiesFromDatabase(to: weather)
        
        // Then
        XCTAssertEqual(weather.id, realmWeather.id)
        XCTAssertEqual(weather.main, realmWeather.headline)
        XCTAssertEqual(weather.description, realmWeather.descriptionText)
        XCTAssertEqual(weather.icon, realmWeather.iconName)
    }
    
    // MARK: - updatePropertiesToDatabase
    func test_updatePropertiesToDatabase_shouldUpdatePropertiesToRealmWeather() {
        // Given
        let realmWeather = RealmWeather()
        let weather = Weather()
        let remoteKey = 2
        weather.id = remoteKey
        weather.main = "name"
        weather.description = "bla"
        weather.icon = "bli"
        
        // When
        realmWeather.updatePropertiesToDatabase(from: weather)
        
        // Then        
        XCTAssertEqual(weather.id, realmWeather.id)
        XCTAssertEqual(weather.main, realmWeather.headline)
        XCTAssertEqual(weather.description, realmWeather.descriptionText)
        XCTAssertEqual(weather.icon, realmWeather.iconName)
    }
    
}
