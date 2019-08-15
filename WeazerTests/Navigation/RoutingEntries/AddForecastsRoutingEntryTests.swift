//
//  AddForecastsRoutingEntryTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class AddForecastsRoutingEntryTests: TestCase {

    // MARK: - viewController
    func test_viewController_shouldNotReturnNil_andHaveAAddForcastsVM() {
        // Given
        let routingEntry = AddForecastsRoutingEntry()
        
        // When
        let viewController = routingEntry.viewController
        
        // Then
        guard let forecastsTVC = viewController as? ForecastsTVC else {
            XCTFail()
            return
        }
        XCTAssert(forecastsTVC.viewModel is AddForecastsVM)
    }
        
    // MARK: - completionBlock
    func test_completionBlock_shouldReturnNil() {
        // Given
        let routingEntry = AddForecastsRoutingEntry()
        
        // When
        let completionBlock = routingEntry.completionBlock
        
        // Then
        XCTAssertNil(completionBlock)
    }

}
