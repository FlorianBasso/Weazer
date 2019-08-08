//
//  RealmModelTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class RealmModelTests: TestCase {
    
    // MARK: - primaryKey
    func test_primaryKey_shouldReturnCorrectKeyPath() {
        // Given & When
        let primaryKey = RealmModel.primaryKey()
        
        // Then
        XCTAssertEqual(primaryKey, #keyPath(RealmModel.remoteKey))
    }
    
    // MARK: - remoteKey
    func test_remoteKey_shouldReturn0ByDefault() {
        // Given
        let realmModel = RealmModel()
        
        // When
        let remoteKey = realmModel.remoteKey
        
        // Then
        XCTAssertEqual(remoteKey, 0)
    }
    
    // MARK: - entity
    func test_entity_shouldReturnAnEntity_andUpdatePropertiesToModel() {
        // Given
        let realmModel = RealmModel()
        let remoteKey = 2
        realmModel.remoteKey = remoteKey
        
        // When
        let entity = realmModel.entity
        
        // Then
        XCTAssertNotNil(entity)
        XCTAssertEqual(entity.remoteKey, realmModel.remoteKey)
    }
    
    // MARK: - updateProperties
    func test_updateProperties_shouldUpdatePropertiesToModel() {
        // Given
        let realmModel = RealmModel()
        let remoteKey = 2
        realmModel.remoteKey = remoteKey
        
        let model = Model()
        
        // When
        realmModel.updateProperties(to: model)
        
        // Then
        XCTAssertEqual(model.remoteKey, realmModel.remoteKey)
    }
    
    // MARK: - configure
    func test_configure_shouldUpdatePropertiesToRealmModel() {
        // Given
        let realmModel = RealmModel()
        let model = Model()
        let remoteKey = 2
        model.remoteKey = remoteKey
        
        // When
        realmModel.configure(model: model)
        
        // Then        
        XCTAssertEqual(model.remoteKey, realmModel.remoteKey)
    }

}
