//
//  WindTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class WindTests: TestCase {

    // MARK: - speed
    func test_speed_shouldReturnCorrectText() {
        // Given & When
        let speed = Wind.Constants.speed
        
        // Then
        XCTAssertEqual(speed, "speed")
    }
    
    // MARK: - degree
    func test_degree_shouldReturnCorrectText() {
        // Given & When
        let degree = Wind.Constants.degree
        
        // Then
        XCTAssertEqual(degree, "deg")
    }
    
    // MARK: - parse
    func test_parse_shouldSetProperties_whenDataIsCorrect() {
        // Given
        let wind = Wind()
        let speed: Double = 68.3
        let degree = 90
        let data: [String : Any] = [Wind.Constants.speed: speed,
                                    Wind.Constants.degree: degree]
        
        // When
        wind.parse(data: data)
        
        // Then
        XCTAssertEqual(wind.degree, degree)
        XCTAssertEqual(wind.speed, speed)
    }
    
    func test_parse_shouldNotSetProperties_whenDataIsNotCorrect() {
        // Given
        let wind = Wind()
        let data = ["wrongKey": "la"]
        
        // When
        wind.parse(data: data)
        
        // Then
        XCTAssertNil(wind.speed)
        XCTAssertNil(wind.degree)
    }
    
    // MARK: - remoteKey
    func test_remoteKey_shouldReturnZero_whenNoWindIsStoredInDatabase() {
        // Given
        let wind = Wind()
        
        // When
        let remoteKey = wind.remoteKey(inRepresentation: [:])
        
        // Then
        XCTAssertEqual(remoteKey, 0)
    }
    
    func test_remoteKey_shouldReturnCorrectValue_whenSomeWindIsStoredInDatabase() {
        // Given
        let wind = Wind()
        self.database.mockGetAll = [wind]
        
        // When
        let remoteKey = wind.remoteKey(inRepresentation: [:])
        
        // Then
        XCTAssertEqual(remoteKey, self.database.mockGetAll!.count + 1)
    }

}
