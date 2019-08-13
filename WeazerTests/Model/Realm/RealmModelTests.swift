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
        let entity = realmModel.entity(forType: Model.self)
        
        // Then
        XCTAssertNotNil(entity)
        XCTAssertEqual(entity.remoteKey, realmModel.remoteKey)
    }
    
    // MARK: - updatePropertiesFromDatabase
    func test_updatePropertiesFromDatabase_shouldUpdatePropertiesToModel() {
        // Given
        let realmModel = RealmModel()
        let remoteKey = 2
        realmModel.remoteKey = remoteKey
        
        let model = Model()
        
        // When
        realmModel.updatePropertiesFromDatabase(to: model)
        
        // Then
        XCTAssertEqual(model.remoteKey, realmModel.remoteKey)
    }
    
    // MARK: - updatePropertiesToDatabase
    func test_updatePropertiesToDatabase_shouldUpdatePropertiesToRealmModel() {
        // Given
        let realmModel = RealmModel()
        let model = Model()
        let remoteKey = 2
        model.remoteKey = remoteKey
        
        // When
        realmModel.updatePropertiesToDatabase(from: model)
        
        // Then        
        XCTAssertEqual(model.remoteKey, realmModel.remoteKey)
    }

}
