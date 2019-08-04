//
//  AddForecastsVMTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
import MapKit
@testable import Weazer

class AddForecastsVMTests: TestCase {

    // MARK: - title
    func test_title_shouldReturnCorrectText() {
        // Given
        let viewModel = AddForecastsVM()
        
        // When
        let title = viewModel.title
        
        // Then
        XCTAssertEqual(title, NSLocalizedString("add.forecasts.title", comment: ""))
    }
    
    // MARK: - rightBarButtonItem
    func test_rightBarButtonItem_shouldReturnCorrectItem() {
        // Given
        let viewModel = AddForecastsVM()
        
        // When
        let rightBarButtonItem = viewModel.rightBarButtonItem
        
        // Then
        XCTAssertNotNil(rightBarButtonItem)
        XCTAssertEqual(rightBarButtonItem!.target as? AddForecastsVM, viewModel)
        XCTAssertNotNil(rightBarButtonItem?.image)
        XCTAssertEqual(rightBarButtonItem!.action, #selector(AddForecastsVM.requestForecastForUserPosition))
    }
    
    // MARK: - searchBarPlaceholder
    func test_searchBarPlaceholder_shouldReturnCorrectText() {
        // Given
        let viewModel = AddForecastsVM()
        
        // When
        let searchBarPlaceholder = viewModel.searchBarPlaceholder
        
        // Then
        XCTAssertEqual(searchBarPlaceholder, NSLocalizedString("add.forecasts.search.placeholder", comment: ""))
    }
    
    // MARK: - sectionToAdd
    func test_sectionToAdd_shouldReturnSectionWithAsManayItemsAsResults() {
        // Given
        let viewModel = AddForecastsVM()
        let aCompletion = MKLocalSearchCompletion()
        viewModel.searchResults.append(aCompletion)
        
        // When
        let section = viewModel.sectionToAdd()
        
        // Then
        XCTAssertEqual(section.items.count, viewModel.searchResults.count)
    }
    
    // MARK: - filterContentForSearchText
    func test_filterContentForSearchText_shouldConfigureSearchCompleter() {
        // Given
        let viewModel = AddForecastsVM()
        let delegate = MockTableViewModelDelegate()
        viewModel.delegate = delegate
        let searchText = "bla"
        
        // When
        viewModel.filterContentForSearchText(searchText)
        
        // Then
        XCTAssert(viewModel.searchCompleter.delegate === viewModel)
        XCTAssertEqual(viewModel.searchCompleter.filterType, .locationsOnly)
        XCTAssertEqual(viewModel.searchCompleter.queryFragment, searchText)
    }  

}
