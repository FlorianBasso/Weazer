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

    // MARK: - modelToUpdate
    func test_modelToUpdate_shouldReturnAForecastMainInfo() {
        // Given
        let realmModel = RealmForecastMainInfo()
        
        // When
        let modelToUpdate = realmModel.modelToUpdate
        
        // Then
        XCTAssertNotNil(modelToUpdate)
        XCTAssert(modelToUpdate is ForecastMainInfo)
    }
    
    // MARK: - updateProperties
    func test_updateProperties_shouldUpdatePropertiesToUser() {
        // Given
        let realmModel = RealmForecastMainInfo()
        let remoteKey = 2
        let remoteKeyString = "\(remoteKey)"
        realmModel.remoteKey = remoteKey
        realmModel.remoteKeyString = remoteKeyString
        realmModel.temperature = 65
        realmModel.temperatureMin = 25
        realmModel.temperatureMax = 85
        realmModel.pressure = 165
        realmModel.humidity = 65
        
        let model = ForecastMainInfo()
        
        // When
        realmModel.updateProperties(to: model)
        
        // Then
        XCTAssertEqual(model.remoteKeyString, realmModel.remoteKeyString)
        XCTAssertEqual(model.remoteKey, realmModel.remoteKey)
        XCTAssertEqual(model.temperature, realmModel.temperature)
        XCTAssertEqual(model.temperatureMin, realmModel.temperatureMin)
        XCTAssertEqual(model.temperatureMax, realmModel.temperatureMax)
        XCTAssertEqual(model.pressure, realmModel.pressure)
        XCTAssertEqual(model.humidity, realmModel.humidity)
    }
    
    // MARK: - configure
    func test_configure_shouldUpdatePropertiesToRealmUser() {
        // Given
        let realmModel = RealmForecastMainInfo()
        let model = ForecastMainInfo()
        let remoteKey = 2
        model.remoteKey = remoteKey
        model.temperature = 65
        model.temperatureMin = 25
        model.temperatureMax = 85
        model.pressure = 165
        model.humidity = 65
        
        // When
        realmModel.configure(model: model)
        
        // Then
        XCTAssertEqual(realmModel.remoteKeyString, "\(realmModel.remoteKey)")
        XCTAssertEqual(model.remoteKey, realmModel.remoteKey)
        XCTAssertEqual(model.temperature, realmModel.temperature)
        XCTAssertEqual(model.temperatureMin, realmModel.temperatureMin)
        XCTAssertEqual(model.temperatureMax, realmModel.temperatureMax)
        XCTAssertEqual(model.pressure, realmModel.pressure)
        XCTAssertEqual(model.humidity, realmModel.humidity)
    }
    

}
