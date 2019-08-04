//
//  ModelTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class ModelTests: TestCase {

    // MARK: - remoteKey
    func test_remoteKey_shouldReturn0ByDefault() {
        // Given
        let model = Model()
        
        // When
        let remoteKey = model.remoteKey
        
        // Then
        XCTAssertEqual(remoteKey, 0)
    }
    
    // MARK: - remoteKeyString
    func test_remoteKeyString_shouldReturn0ByDefault() {
        // Given
        let model = Model()
        
        // When
        let remoteKeyString = model.remoteKeyString
        
        // Then
        XCTAssertEqual(remoteKeyString, "0")
    }
    
    // MARK: - id
    func test_id_shouldReturnId() {
        // Given & When
        let id = Model.Constants.id
        
        // Then
        XCTAssertEqual(id, "id")
    }

    // MARK: - initRemoteKey
    func test_initRemoteKey_shouldReturnNil_whenRemoteKeyIs0() {
        // Given
        let remoteKey = 0
        
        // When
        let model = Model(remoteKey: remoteKey)
        
        // Then
        XCTAssertNil(model)
    }
    
    func test_initRemoteKey_shouldNotReturnNil_whenRemoteKeyIsNot0_andSetRemoteKey() {
        // Given
        let remoteKey = 2
        
        // When
        let model = Model(remoteKey: remoteKey)
        
        // Then
        XCTAssertNotNil(model)
        XCTAssertEqual(remoteKey, model?.remoteKey)
    }
    
    // MARK: - initData
    func test_initData_shouldSetRemoteKey() {
        // Given
        let remoteKey = 2
        let data = [Model.Constants.id: remoteKey]
        
        // When
        let model = Model(data: data)
        
        // Then
        XCTAssertEqual(remoteKey, model.remoteKey)
    }
    
    // MARK: - commonInit
    func test_commonInit_shouldSetRemoteKey() {
        // Given
        let remoteKey = 2
        let data = [Model.Constants.id: remoteKey]
        let model = Model()
        
        // When
        model.commonInit(data: data)
        
        // Then
        XCTAssertEqual(remoteKey, model.remoteKey)
    }
    
    // MARK: - remoteKeyInRepresentation
    func test_remoteKeyInRepresentation_shouldReturnCorrectRemoteKey_whenDataIsCorrect() {
        // Given
        let data = [Model.Constants.id: 2]
        let model = Model()
        
        // When
        let remoteKey = model.remoteKey(inRepresentation: data)
        
        // Then
        XCTAssertEqual(remoteKey, 2)
    }
    
    func test_remoteKeyInRepresentation_shouldReturn0_whenDataIsNotCorrect() {
        // Given
        let data = ["wrongKey": 2]
        let model = Model()
        
        // When
        let remoteKey = model.remoteKey(inRepresentation: data)
        
        // Then
        XCTAssertEqual(remoteKey, 0)
    }
    
    // MARK: - parseArray
    func test_parseArray_shouldReturnNil_whenDataIsNil() {
        // Given
        let data: [[AnyHashable:Any]]? = nil
        
        // When
        let array = Model.parseArray(data: data)
        
        // Then
        XCTAssertNil(array)
    }
    
    func test_parseArray_shouldReturnArrayOfModels_whenDataIsNotNil() {
        // Given
        let data: [[AnyHashable:Any]]? = [[Model.Constants.id: 2]]
        
        // When
        let array = Model.parseArray(data: data)
        
        // Then
        XCTAssertNotNil(array)
        XCTAssertEqual(array?.count, 1)
    }
    
    // MARK: - isEqual
    func test_isEqual_shouldReturnFalse_whenOtherObjectIsNotAModel() {
        // Given
        let otherObject = "something else"
        let remoteKey = 2
        let model = Model(remoteKey: remoteKey)!
        
        // When
        let isEqual = model.isEqual(otherObject)
        
        // Then
        XCTAssertFalse(isEqual)
    }
    
    func test_isEqual_shouldReturnFalse_whenOtherObjectIsAModel_butNotTheSameType() {
        // Given
        let remoteKey = 2
        let weather = Weather(remoteKey: remoteKey)
        let model = Model(remoteKey: remoteKey)!
        
        // When
        let isEqual = model.isEqual(weather)
        
        // Then
        XCTAssertFalse(isEqual)
    }
    
    func test_isEqual_shouldReturnTrue_whenOtherObjectIsAModel_hasTheSameType_andTheSameRemoteKey() {
        // Given
        let remoteKey = 2
        let otherModel = Model(remoteKey: remoteKey)
        let model = Model(remoteKey: remoteKey)!
        
        // When
        let isEqual = model.isEqual(otherModel)
        
        // Then
        XCTAssert(isEqual)
    }
    
    func test_isEqual_shouldReturnFalse_whenOtherObjectIsAModel_hasTheSameType_andNotTheSameRemoteKey() {
        // Given
        let otherModel = Model(remoteKey: 3)
        let model = Model(remoteKey: 2)!
        
        // When
        let isEqual = model.isEqual(otherModel)
        
        // Then
        XCTAssertFalse(isEqual)
    }
}
