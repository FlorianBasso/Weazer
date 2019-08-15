//
//  CityCellViewModelTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class CityCellViewModelTests: TestCase {

    // MARK: - init
    func test_init_shouldSetProperties() {
        // Given
        let cityName = "Paris"
        
        // When
        let cellViewModel = CityCellViewModel(cityName: cityName)
        
        // Then
        XCTAssertEqual(cityName, cellViewModel.cityName)
    }
    
    // MARK: - reuseIdentifier
    func test_reuseIdentifier_shouldReturnUITableViewCell() {
        // Given
        let cellViewModel = self.cellViewModelToTest()
        
        // When
        let reuseIdentifier = cellViewModel.reuseIdentifier
        
        // Then
        XCTAssertEqual(reuseIdentifier, String(describing: UITableViewCell.self))
    }
    
    // MARK: - estimatedHeight
    func test_estimatedHeight_shouldReturn50() {
        // Given
        let cellViewModel = self.cellViewModelToTest()
        
        // When
        let estimatedHeight = cellViewModel.estimatedHeight()
        
        // Then
        XCTAssertEqual(estimatedHeight, UITableView.automaticDimension)
    }
    
    // MARK: - willDisplay
    func test_willDisplay_shouldSetDataOnCell() {
        // Given
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "reuseIdentifier")
        let cellViewModel = self.cellViewModelToTest()
        
        let name = "name"
        cellViewModel.cityName = name
        
        // When
        cellViewModel.willDisplay(cell)
        
        // Then
        XCTAssertEqual(cell.textLabel?.text, name)
        XCTAssertEqual(cell.textLabel?.textColor, .white)
        XCTAssertEqual(cell.backgroundColor, .clear)
    }
    
    // MARK: - didSelect
    func test_didSelect_shouldCallAPI_saveRepoToDatabase_andPopScreen() {
        // Given
        let forecast = Forecast()
        let cellViewModel = self.cellViewModelToTest()
        self.api.mockResult = Result.success(forecast)
        
        // When
        cellViewModel.didSelect(fromVC: nil)
        
        // Then
        XCTAssert(self.api.lastEndpoint is GetCurrentWeatherDataEndpoint)
        XCTAssertEqual(self.database.itemInserted as! Forecast, forecast)
        XCTAssert(self.routing.lastRoutingEntry is PopRoutingEntry)
    }
    
    // MARK: - Helper Method
    func cellViewModelToTest() -> CityCellViewModel {
        let cityName = "Paris"
        let cellViewModel = CityCellViewModel(cityName: cityName)
        return cellViewModel
    }

}
