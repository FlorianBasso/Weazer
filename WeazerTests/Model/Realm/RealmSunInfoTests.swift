//
//  RealmSunInfoTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class RealmSunInfoTests: TestCase {

    // MARK: - updatePropertiesFromDatabase
    func test_updatePropertiesFromDatabase_shouldUpdatePropertiesToUser() {
        // Given
        let realmModel = RealmSunInfo()
        let remoteKey = 2
        realmModel.id = remoteKey        
        realmModel.sunsetDate = Date(timeIntervalSince1970: 4343)
        realmModel.sunriseDate = Date(timeIntervalSince1970: 4343434)
        
        let model = SunInfo()
        
        // When
        realmModel.updatePropertiesFromDatabase(to: model)
        
        // Then
        XCTAssertEqual(model.id, realmModel.id)
        XCTAssertEqual(model.sunrise, realmModel.sunriseDate)
        XCTAssertEqual(model.sunset, realmModel.sunsetDate)
    }
    
    // MARK: - updatePropertiesToDatabase
    func test_updatePropertiesToDatabase_shouldUpdatePropertiesToRealmUser() {
        // Given
        let realmModel = RealmSunInfo()
        let model = SunInfo()
        let remoteKey = 2
        model.id = remoteKey
        model.sunset = Date(timeIntervalSince1970: 4343)
        model.sunrise = Date(timeIntervalSince1970: 4343434)
        
        // When
        realmModel.updatePropertiesToDatabase(from: model)
        
        // Then        
        XCTAssertEqual(model.id, realmModel.id)
        XCTAssertEqual(model.sunrise, realmModel.sunriseDate)
        XCTAssertEqual(model.sunset, realmModel.sunsetDate)
    }


}
