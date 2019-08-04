//
//  SectionTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class SectionTests: TestCase {
   
    // MARK: - position
    func test_position_shouldReturn0ByDefault() {
        // Given
        let section = Section()
        
        // When
        let position = section.position
        
        // Then
        XCTAssertEqual(position, 0)
    }
    
    // MARK: - items
    func test_items_shouldNeverReturnNil() {
        // Given
        let section = Section()
        
        // When
        let items = section.items
        
        // Then
        XCTAssertEqual(items.count, 0)
        XCTAssertNotNil(items)
    }

}
