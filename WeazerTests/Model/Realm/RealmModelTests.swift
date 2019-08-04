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
        XCTAssertEqual(primaryKey, #keyPath(RealmModel.remoteKeyString))
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
    
    // MARK: - remoteKeyString
    func test_remoteKeyString_shouldReturnAnEmptyStringByDefault() {
        // Given
        let realmModel = RealmModel()
        
        // When
        let remoteKeyString = realmModel.remoteKeyString
        
        // Then
        XCTAssertEqual(remoteKeyString, "")
    }
    
    // MARK: - modelToUpdate
    func test_modelToUpdate_shouldReturnAModel() {
        // Given
        let realmModel = RealmModel()
        
        // When
        let modelToUpdate = realmModel.modelToUpdate
        
        // Then
        XCTAssertNotNil(modelToUpdate)
    }
    
    // MARK: - entity
    func test_entity_shouldReturnAnEntity_andUpdatePropertiesToModel() {
        // Given
        let realmModel = RealmModel()
        let remoteKey = 2
        let remoteKeyString = "\(remoteKey)"
        realmModel.remoteKey = remoteKey
        realmModel.remoteKeyString = remoteKeyString
        
        // When
        let entity = realmModel.entity
        
        // Then
        XCTAssertNotNil(entity)
        XCTAssertEqual(entity.remoteKeyString, realmModel.remoteKeyString)
        XCTAssertEqual(entity.remoteKey, realmModel.remoteKey)
    }
    
    // MARK: - updateProperties
    func test_updateProperties_shouldUpdatePropertiesToModel() {
        // Given
        let realmModel = RealmModel()
        let remoteKey = 2
        let remoteKeyString = "\(remoteKey)"
        realmModel.remoteKey = remoteKey
        realmModel.remoteKeyString = remoteKeyString
        
        let model = Model()
        
        // When
        realmModel.updateProperties(to: model)
        
        // Then
        XCTAssertEqual(model.remoteKeyString, realmModel.remoteKeyString)
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
        XCTAssertEqual(realmModel.remoteKeyString, "\(realmModel.remoteKey)")
        XCTAssertEqual(model.remoteKey, realmModel.remoteKey)
    }
    
    // MARK: - configureRemoteKeyString
    func test_configureRemoteKeyString_shouldNotSetRemoteKeyString_whenRemoteKeyIs0() {
        // Given
        let realmModel = RealmModel()
        let remoteKey = 0
        realmModel.remoteKey = remoteKey
        
        // When
        realmModel.configureRemoteKeyString()
        
        // Then
        XCTAssertEqual(realmModel.remoteKeyString, "")
    }
    
    func test_configureRemoteKeyString_shouldSetRemoteKeyString_whenRemoteKeyIsNot0() {
        // Given
        let realmModel = RealmModel()
        let remoteKey = 2
        realmModel.remoteKey = remoteKey
        
        // When
        realmModel.configureRemoteKeyString()
        
        // Then
        XCTAssertEqual(realmModel.remoteKeyString, "2")
    }

}
