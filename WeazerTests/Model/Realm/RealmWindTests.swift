//
//  RealmWindTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class RealmWindTests: TestCase {
    
    // MARK: - updatePropertiesFromDatabase
    func test_updatePropertiesFromDatabase_shouldUpdatePropertiesToUser() {
        // Given
        let realmModel = RealmWind()
        let remoteKey = 2
        realmModel.remoteKey = remoteKey
        realmModel.speed = 65
        realmModel.degree = 25
        
        let model = Wind()
        
        // When
        realmModel.updatePropertiesFromDatabase(to: model)
        
        // Then        
        XCTAssertEqual(model.remoteKey, realmModel.remoteKey)
        XCTAssertEqual(model.speed, realmModel.speed)
        XCTAssertEqual(model.degree, realmModel.degree)
    }
    
    // MARK: - updatePropertiesToDatabase
    func test_updatePropertiesToDatabase_shouldUpdatePropertiesToRealmUser() {
        // Given
        let realmModel = RealmWind()
        let model = Wind()
        let remoteKey = 2
        model.remoteKey = remoteKey
        model.speed = 65
        model.degree = 25
        
        // When
        realmModel.updatePropertiesToDatabase(from: model)
        
        // Then        
        XCTAssertEqual(model.remoteKey, realmModel.remoteKey)
        XCTAssertEqual(model.speed, realmModel.speed)
        XCTAssertEqual(model.degree, realmModel.degree)        
    }


}
