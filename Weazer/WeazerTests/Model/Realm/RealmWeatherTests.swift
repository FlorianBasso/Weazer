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

    // MARK: - modelToUpdate
    func test_modelToUpdate_shouldReturnAWeather() {
        // Given
        let realmModel = RealmWeather()
        
        // When
        let modelToUpdate = realmModel.modelToUpdate
        
        // Then
        XCTAssertNotNil(modelToUpdate)
        XCTAssert(modelToUpdate is Weather)
    }
    
    // MARK: - updateProperties
    func test_updateProperties_shouldUpdatePropertiesToWeather() {
        // Given
        let realmWeather = RealmWeather()
        let remoteKey = 2
        let remoteKeyString = "\(remoteKey)"
        realmWeather.remoteKey = remoteKey
        realmWeather.remoteKeyString = remoteKeyString
        realmWeather.headline = "headline"
        realmWeather.descriptionText = "bla"
        realmWeather.iconName = "bli"
        
        let weather = Weather()
        
        // When
        realmWeather.updateProperties(to: weather)
        
        // Then
        XCTAssertEqual(weather.remoteKeyString, realmWeather.remoteKeyString)
        XCTAssertEqual(weather.remoteKey, realmWeather.remoteKey)
        XCTAssertEqual(weather.headline, realmWeather.headline)
        XCTAssertEqual(weather.descriptionText, realmWeather.descriptionText)
        XCTAssertEqual(weather.iconName, realmWeather.iconName)
    }
    
    // MARK: - configure
    func test_configure_shouldUpdatePropertiesToRealmWeather() {
        // Given
        let realmWeather = RealmWeather()
        let weather = Weather()
        let remoteKey = 2
        weather.remoteKey = remoteKey
        weather.headline = "name"
        weather.descriptionText = "bla"
        weather.iconName = "bli"
        
        // When
        realmWeather.configure(model: weather)
        
        // Then
        XCTAssertEqual(realmWeather.remoteKeyString, "\(realmWeather.remoteKey)")
        XCTAssertEqual(weather.remoteKey, realmWeather.remoteKey)
        XCTAssertEqual(weather.headline, realmWeather.headline)
        XCTAssertEqual(weather.descriptionText, realmWeather.descriptionText)
        XCTAssertEqual(weather.iconName, realmWeather.iconName)
    }
    
}
