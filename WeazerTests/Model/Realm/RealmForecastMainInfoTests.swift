//
//  RealmForecastMainInfoTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class RealmForecastMainInfoTests: TestCase {
    
    // MARK: - updatePropertiesFromDatabase
    func test_updatePropertiesFromDatabase_shouldUpdatePropertiesToUser() {
        // Given
        let realmModel = RealmForecastMainInfo()
        let remoteKey = 2
        realmModel.id = remoteKey
        realmModel.temperature = 65
        realmModel.temperatureMin = 25
        realmModel.temperatureMax = 85
        realmModel.pressure = 165
        realmModel.humidity = 65
        
        let model = ForecastMainInfo()
        
        // When
        realmModel.updatePropertiesFromDatabase(to: model)
        
        // Then
        XCTAssertEqual(model.id, realmModel.id)
        XCTAssertEqual(model.temp, realmModel.temperature)
        XCTAssertEqual(model.tempMin, realmModel.temperatureMin)
        XCTAssertEqual(model.tempMax, realmModel.temperatureMax)
        XCTAssertEqual(model.pressure, realmModel.pressure)
        XCTAssertEqual(model.humidity, realmModel.humidity)
    }
    
    // MARK: - updatePropertiesToDatabase
    func test_updatePropertiesToDatabase_shouldUpdatePropertiesToRealmUser() {
        // Given
        let realmModel = RealmForecastMainInfo()
        let model = ForecastMainInfo()
        let remoteKey = 2
        model.id = remoteKey
        model.temp = 65
        model.tempMin = 25
        model.tempMax = 85
        model.pressure = 165
        model.humidity = 65
        
        // When
        realmModel.updatePropertiesToDatabase(from: model)
        
        // Then        
        XCTAssertEqual(model.id, realmModel.id)
        XCTAssertEqual(model.temp, realmModel.temperature)
        XCTAssertEqual(model.tempMin, realmModel.temperatureMin)
        XCTAssertEqual(model.tempMax, realmModel.temperatureMax)
        XCTAssertEqual(model.pressure, realmModel.pressure)
        XCTAssertEqual(model.humidity, realmModel.humidity)
    }
    

}
