//
//  ForecastCellViewModelTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class ForecastCellViewModelTests: TestCase {

    // MARK: - init
    func test_init_shouldSetProperties() {
        // Given
        let forecast = Forecast()
        let unitFormatIsImperial = false
        
        // When
        let cellViewModel = ForecastCellViewModel(forecast: forecast, unitFormatIsImperial: unitFormatIsImperial)
        
        // Then
        XCTAssertEqual(forecast, cellViewModel.forecast)
        XCTAssertEqual(unitFormatIsImperial, cellViewModel.unitFormatIsImperial)
    }
    
    // MARK: - reuseIdentifier
    func test_reuseIdentifier_shouldReturnForecastCell() {
        // Given
        let cellViewModel = self.cellViewModelToTest()
        
        // When
        let reuseIdentifier = cellViewModel.reuseIdentifier
        
        // Then
        XCTAssertEqual(reuseIdentifier, String(describing: ForecastCell.self))
    }
    
    // MARK: - cellHeight
    func test_cellHeight_shouldReturn100() {
        // Given
        let cellViewModel = self.cellViewModelToTest()
        
        // When
        let cellHeight = cellViewModel.cellHeight(CGSize.zero)
        
        // Then
        XCTAssertEqual(cellHeight, 100)
    }
    
    // MARK: - willDisplay
    func test_willDisplay_shouldSetDataOnCell() {
        // Given
        let cell = Bundle(for: ForecastCell.self).loadNibNamed(String(describing: ForecastCell.self), owner: self, options: nil)?.first as! ForecastCell
        let cellViewModel = self.cellViewModelToTest()
        let name = "name"
        cellViewModel.forecast.name = name
        
        // When
        cellViewModel.willDisplay(cell)
        
        // Then
        XCTAssertEqual(cell.cityNameLabel?.text, name)
        XCTAssertEqual(cell.cityNameLabel?.textColor, .white)
        XCTAssertEqual(cell.backgroundColor, .clear)
    }
    
    // MARK: - didSelect
    func test_didSelect_shouldRouteToForecastDetailRoutingEntry_whenInteractionIsEnabled() {
        // Given
        let cellViewModel = self.cellViewModelToTest()
        cellViewModel.shouldHandleSelection = true
        
        let fromVC = UIViewController()
        _ = UINavigationController(rootViewController: fromVC)
        
        // When
        cellViewModel.didSelect(fromVC: fromVC)
        
        // Then
        guard let pushNavStyle = self.routing.lastNavigationStyle as? PushNavigationStyle else {
            XCTFail()
            return
        }
        
        XCTAssert(pushNavStyle.routingEntry is ForecastDetailRoutingEntry)
    }
    
    // MARK: - Helper Method
    func cellViewModelToTest() -> ForecastCellViewModel {
        let forecast = Forecast()
        let unitFormatIsImperial = false
        let cellViewModel = ForecastCellViewModel(forecast: forecast, unitFormatIsImperial: unitFormatIsImperial)
        return cellViewModel
    }


}
