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
        XCTAssertEqual(primaryKey, #keyPath(RealmModel.id))
    }
    
    // MARK: - remoteKey
    func test_remoteKey_shouldReturn0ByDefault() {
        // Given
        let realmModel = RealmModel()
        
        // When
        let remoteKey = realmModel.id
        
        // Then
        XCTAssertEqual(remoteKey, 0)
    }
    
    // MARK: - entity
    func test_entity_shouldReturnAnEntity_andUpdatePropertiesToModel() {
        // Given
        let realmModel = RealmModel()
        
        // When
        let entity = realmModel.entity(forType: Forecast.self)
        
        // Then
        XCTAssertNotNil(entity)        
    }
    
  

}
