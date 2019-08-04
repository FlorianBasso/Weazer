//
//  SearchableTVMTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class SearchableTVMTests: TestCase {
    
    // MARK: - searchBarPlaceholder
    func test_searchBarPlaceholder_shouldReturnNil() {
        // Given
        let viewModel = SearchableTVM()
        
        // When
        let searchBarPlaceholder = viewModel.searchBarPlaceholder
        
        // Then
        XCTAssertNil(searchBarPlaceholder)
    }
    

    // MARK: - loadSections
    func test_loadSections_shouldHaveNoSection() {
        // Given
        let viewModel = SearchableTVM()
        
        // When
        viewModel.loadSections()
        
        // Then
        XCTAssertEqual(viewModel.sections.count, 0)
    }
    
    // MARK: - configureSearchController
    func test_configureSearchController() {
        // Given
        let viewModel = SearchableTVM()
        let vc = UIViewController()
        
        // When
        viewModel.configureSearchController(viewController: vc)
        
        // Then
        guard let searchController = viewModel.searchController else {
            XCTFail()
            return
        }
                
        XCTAssertEqual(searchController.searchBar.isTranslucent, true)
        XCTAssertEqual(searchController.searchBar.tintColor, .white)
        XCTAssert(searchController.searchResultsUpdater === viewModel)
        XCTAssertEqual(searchController.searchBar.placeholder, viewModel.searchBarPlaceholder)
        
        XCTAssert(vc.definesPresentationContext)
        
        XCTAssertFalse(searchController.obscuresBackgroundDuringPresentation)
        
        XCTAssert(searchController.delegate === viewModel)
    }

}
