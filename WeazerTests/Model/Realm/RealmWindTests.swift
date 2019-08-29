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
        realmModel.id = remoteKey
        realmModel.speed = 65
        realmModel.degree = 25
        
        let model = Wind()
        
        // When
        realmModel.updatePropertiesFromDatabase(to: model)
        
        // Then        
        XCTAssertEqual(model.id, realmModel.id)
        XCTAssertEqual(model.speed, realmModel.speed)
        XCTAssertEqual(model.deg, realmModel.degree)
    }
    
    // MARK: - updatePropertiesToDatabase
    func test_updatePropertiesToDatabase_shouldUpdatePropertiesToRealmUser() {
        // Given
        let realmModel = RealmWind()
        let model = Wind()
        let remoteKey = 2
        model.id = remoteKey
        model.speed = 65
        model.deg = 25
        
        // When
        realmModel.updatePropertiesToDatabase(from: model)
        
        // Then        
        XCTAssertEqual(model.id, realmModel.id)
        XCTAssertEqual(model.speed, realmModel.speed)
        XCTAssertEqual(model.deg, realmModel.degree)        
    }


}
