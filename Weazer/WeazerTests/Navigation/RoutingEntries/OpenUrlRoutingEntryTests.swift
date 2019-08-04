//
//  OpenUrlRoutingEntryTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class OpenUrlRoutingEntryTests: TestCase {

    // MARK: - viewController
    func test_viewController_shouldReturnNil() {
        // Given
        let routingEntry = OpenUrlRoutingEntry(url: "")
        
        // When
        let viewController = routingEntry.viewController
        
        // Then
        XCTAssertNil(viewController)
    }
    
    // MARK: - navigationStyle
    func test_navigationStyle_shouldReturnOpenUrl() {
        // Given
        let routingEntry = OpenUrlRoutingEntry(url: "")
        
        // When
        let navigationStyle = routingEntry.navigationStyle
        
        // Then
        XCTAssert(navigationStyle == .openUrl)
    }
    
    // MARK: - animated
    func test_animated_shouldReturnTrue() {
        // Given
        let routingEntry = OpenUrlRoutingEntry(url: "")
        
        // When
        let animated = routingEntry.animated
        
        // Then
        XCTAssert(animated)
    }
    
    // MARK: - completionBlock
    func test_completionBlock_shouldReturnNil() {
        // Given
        let routingEntry = OpenUrlRoutingEntry(url: "")
        
        // When
        let completionBlock = routingEntry.completionBlock
        
        // Then
        XCTAssertNil(completionBlock)
    }
    
    // MARK: - init
    func test_init_shouldSetUrl() {
        // Given
        let urlString = "url"
        
        // When
        let routingEntry = OpenUrlRoutingEntry(url: urlString)
        
        // Then
        XCTAssertEqual(urlString, routingEntry.externUrl)
    }
    
    // MARK: - url
    func test_url_shouldReturnUrl() {
        // Given
        let urlString = "url"
        let routingEntry = OpenUrlRoutingEntry(url: urlString)
        
        // When
        let url = routingEntry.url
        
        // Then
        XCTAssertEqual(urlString, url)
    }

}
