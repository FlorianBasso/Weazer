//
//  TableCellViewModelTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
import UIKit
@testable import Weazer

class TableCellViewModelTests: TestCase {
    
    //MARK: - reuseIdentifier
    func test_reuseIdentifier_shouldReturnCorrectIdentifier() {
        // Given
        let item = TableCellViewModel()
        
        // When
        let identifier = item.reuseIdentifier
        
        // Then
        XCTAssertEqual(identifier, NSStringFromClass(UITableViewCell.self))
    }
    
    // MARK: - cellNib
    func test_cellNib_shouldNotReturnNil() {
        // Given
        let item = TableCellViewModel()
        
        // When
        let nib = item.cellNib
        
        // Then
        XCTAssertNotNil(nib)
    }
    
    // MARK: - configureCell
    func test_configureCell_shouldSetSelectionStyleToNone() {
        // Given
        let cell = UITableViewCell()
        let item = TableCellViewModel()
        
        // When
        item.configureCell(cell)
        
        // Then
        XCTAssert(cell.selectionStyle == .none)
    }
    
    // MARK: - estimatedHeight
    func test_estimatedHeight_shouldReturnUITableViewAutomaticDimension() {
        // Given
        let item = TableCellViewModel()
        
        // When
        let height = item.estimatedHeight()
        
        // Then
        XCTAssertEqual(height, UITableView.automaticDimension)
    }
    
    // MARK: - cellHeight
    func test_cellHeight_shouldReturnUITableViewAutomaticDimension() {
        // Given
        let item = TableCellViewModel()
        let maxSize = CGSize(width: 300, height: 300)
        
        // When
        let height = item.cellHeight(maxSize)
        
        // Then
        XCTAssertEqual(height, UITableView.automaticDimension)
    }
            
}
