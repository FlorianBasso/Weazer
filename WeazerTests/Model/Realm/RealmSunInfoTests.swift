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

    // MARK: - updateProperties
    func test_updateProperties_shouldUpdatePropertiesToUser() {
        // Given
        let realmModel = RealmSunInfo()
        let remoteKey = 2
        realmModel.remoteKey = remoteKey        
        realmModel.sunsetDate = Date(timeIntervalSince1970: 4343)
        realmModel.sunriseDate = Date(timeIntervalSince1970: 4343434)
        
        let model = SunInfo()
        
        // When
        realmModel.updateProperties(to: model)
        
        // Then
        XCTAssertEqual(model.remoteKey, realmModel.remoteKey)
        XCTAssertEqual(model.sunriseDate, realmModel.sunriseDate)
        XCTAssertEqual(model.sunsetDate, realmModel.sunsetDate)
    }
    
    // MARK: - configure
    func test_configure_shouldUpdatePropertiesToRealmUser() {
        // Given
        let realmModel = RealmSunInfo()
        let model = SunInfo()
        let remoteKey = 2
        model.remoteKey = remoteKey
        model.sunsetDate = Date(timeIntervalSince1970: 4343)
        model.sunriseDate = Date(timeIntervalSince1970: 4343434)
        
        // When
        realmModel.configure(model: model)
        
        // Then        
        XCTAssertEqual(model.remoteKey, realmModel.remoteKey)
        XCTAssertEqual(model.sunriseDate, realmModel.sunriseDate)
        XCTAssertEqual(model.sunsetDate, realmModel.sunsetDate)
    }


}
