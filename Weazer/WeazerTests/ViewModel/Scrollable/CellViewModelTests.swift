//
//  CellViewModelTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class CellViewModelTests: TestCase {

    // MARK: - reuseIdentifier
    func test_reuseIdentifier_shouldReturnEmptyText() {
        // Given
        let cellViewModel = CellViewModel()
        
        // When
        let reuseIdentifier = cellViewModel.reuseIdentifier
        
        // Then
        XCTAssertEqual(reuseIdentifier, "")
    }
    
    // MARK: - bundleForNib
    func test_bundleForNib_shouldNotReturnNil() {
        // Given
        let cellViewModel = CellViewModel()
        
        // When
        let bundleForNib = cellViewModel.bundleForNib
        
        // Then
        XCTAssertNotNil(bundleForNib)
    }

    // MARK: - cellNib
    func test_cellNib_shouldReturnNil_whenReuseIdentifierIsEmpty() {
        // Given
        let cellViewModel = CellViewModel()
        
        // When
        let cellNib = cellViewModel.cellNib
        
        // Then
        XCTAssertNil(cellNib)
    }

    
}
