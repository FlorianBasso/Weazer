//
//  PopRoutingEntryTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class PopRoutingEntryTests: TestCase {

    // MARK: - viewController
    func test_viewController_shouldReturnNil() {
        // Given
        let routingEntry = PopRoutingEntry()
        
        // When
        let viewController = routingEntry.viewController
        
        // Then
        XCTAssertNil(viewController)
    }
    
    // MARK: - navigationStyle
    func test_navigationStyle_shouldReturnPop() {
        // Given
        let routingEntry = PopRoutingEntry()
        
        // When
        let navigationStyle = routingEntry.navigationStyle
        
        // Then
        XCTAssert(navigationStyle == .pop)
    }
    
    // MARK: - animated
    func test_animated_shouldReturnTrue() {
        // Given
        let routingEntry = PopRoutingEntry()
        
        // When
        let animated = routingEntry.animated
        
        // Then
        XCTAssert(animated)
    }
    
    // MARK: - completionBlock
    func test_completionBlock_shouldReturnNil() {
        // Given
        let routingEntry = PopRoutingEntry()
        
        // When
        let completionBlock = routingEntry.completionBlock
        
        // Then
        XCTAssertNil(completionBlock)
    }

  
}
