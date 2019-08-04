//
//  ForecastDetailRoutingEntryTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class ForecastDetailRoutingEntryTests: TestCase {

    // MARK: - viewController
    func test_viewController_shouldNotReturnNil_andHaveAAddForcastsVM() {
        // Given
        let routingEntry = self.routingEntryToTest()
        
        // When
        let viewController = routingEntry.viewController
        
        // Then
        guard let forecastsTVC = viewController as? ForecastsTVC else {
            XCTFail()
            return
        }
        XCTAssert(forecastsTVC.viewModel is ForecastDetailVM)
    }
    
    // MARK: - navigationStyle
    func test_navigationStyle_shouldReturnPush() {
        // Given
        let routingEntry = self.routingEntryToTest()
        
        // When
        let navigationStyle = routingEntry.navigationStyle
        
        // Then
        XCTAssert(navigationStyle == .push)
    }
    
    // MARK: - animated
    func test_animated_shouldReturnTrue() {
        // Given
        let routingEntry = self.routingEntryToTest()
        
        // When
        let animated = routingEntry.animated
        
        // Then
        XCTAssert(animated)
    }
    
    // MARK: - completionBlock
    func test_completionBlock_shouldReturnNil() {
        // Given
        let routingEntry = self.routingEntryToTest()
        
        // When
        let completionBlock = routingEntry.completionBlock
        
        // Then
        XCTAssertNil(completionBlock)
    }
    
    // MARK: - url
    func test_url_shouldReturnNil() {
        // Given
        let routingEntry = self.routingEntryToTest()
        
        // When
        let url = routingEntry.url
        
        // Then
        XCTAssertNil(url)
    }
    
    // MARK: - init
    func test_init_shouldSetProperties() {
        // Given
        let forecast = Forecast()
        let unitFormatIsImperial = false
        
        // When
        let routingEntry = ForecastDetailRoutingEntry(forecast: forecast, unitFormatIsImperial: unitFormatIsImperial)
        
        // Then
        XCTAssertEqual(forecast, routingEntry.forecast)
        XCTAssertEqual(unitFormatIsImperial, routingEntry.unitFormatIsImperial)
    }
    
    
    // MARK: - Helper
    func routingEntryToTest() -> ForecastDetailRoutingEntry {
        let forecast = Forecast()
        let unitFormatIsImperial = false
        let routingEntry = ForecastDetailRoutingEntry(forecast: forecast, unitFormatIsImperial: unitFormatIsImperial)
        return routingEntry
    }

}
