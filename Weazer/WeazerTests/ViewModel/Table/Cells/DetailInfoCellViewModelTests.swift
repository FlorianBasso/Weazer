//
//  DetailInfoCellViewModelTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class DetailInfoCellViewModelTests: TestCase {

    // MARK: - init
    func test_init_shouldSetProperties() {
        // Given
        let title = "Weather"
        let info = "bla"
        
        // When
        let cellViewModel = DetailInfoCellViewModel(title: title, info: info)
        
        // Then
        XCTAssertEqual(title, cellViewModel.title)
        XCTAssertEqual(info, cellViewModel.info)
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
        
        // When
        cellViewModel.willDisplay(cell)
        
        // Then
        XCTAssertEqual(cell.textLabel?.text, cellViewModel.title)
        XCTAssertEqual(cell.textLabel?.textColor, .white)
        XCTAssertEqual(cell.backgroundColor, .clear)
        XCTAssertEqual(cell.detailTextLabel?.text, cellViewModel.info)
        XCTAssertEqual(cell.detailTextLabel?.textColor, .white)
    }
    
    // MARK: - Helper Method
    func cellViewModelToTest() -> DetailInfoCellViewModel {
        let title = "Weather"
        let info = "bla"
        let cellViewModel = DetailInfoCellViewModel(title: title, info: info)
        return cellViewModel
    }


}
