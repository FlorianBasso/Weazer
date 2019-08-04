//
//  TableViewModelTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
import UIKit
@testable import Weazer

class TableViewModelTests: TestCase {

    // MARK: - numberOfSectionsInTableView
    func test_numberOfSectionsInTableView_shouldBeEqualToNumberOfItems() {
        // Given
        let viewModel = self.viewModelToTestWithItems()
        let tableView = UITableView()
        
        // When
        let numberOfSections = viewModel.numberOfSections(in: tableView)
        
        // Then
        XCTAssertEqual(numberOfSections, viewModel.sections.count)
    }
    
    // MARK: - numberOfRowsInSection
    
    func test_numberOfRowsInSection_shouldBeEqualToNumberOfSectionsInItems() {
        // Given
        let viewModel = self.viewModelToTestWithItems()
        let tableView = UITableView()
        
        for sectionIndex in 0..<viewModel.sections.count {
            // When
            let numberOfRows = viewModel.tableView(tableView, numberOfRowsInSection: sectionIndex)
            
            // Then
            XCTAssertEqual(numberOfRows, (viewModel.sections[sectionIndex] as! TableSection).items.count)
        }
    }
    
    func test_numberOfRowsInSection_shouldReturn0() {
        // Given
        let viewModel = self.viewModelEmptyToTest()
        let tableView = UITableView()
        
        for sectionIndex in 0..<5 {
            // When
            let numberOfRows = viewModel.tableView(tableView, numberOfRowsInSection: sectionIndex)
            
            // Then
            XCTAssertEqual(numberOfRows, 0)
        }
    }
    
    // MARK: - cellForRowAtIndexPath
    func test_cellForRowAtIndexPath_shouldReturnTableCellViewModel() {
        // Given
        let viewModel = self.viewModelToTestWithItems()
        let tableView = UITableView()
        
        for sectionIndex in 0..<viewModel.sections.count {
            let numberOfRows = viewModel.tableView(tableView, numberOfRowsInSection: sectionIndex)
            
            for row in 0..<numberOfRows {
                let indexPath = IndexPath(row: row, section: sectionIndex)
                // When
                let cell = viewModel.tableView(tableView, cellForRowAt: indexPath)
                let item = (viewModel.sections[sectionIndex]).items[row] as! TableCellViewModel
                
                // Then
                XCTAssertEqual(item.indexPath, indexPath)
                XCTAssertNotNil(cell)
            }
        }
    }

    // MARK: - heightForRowAtIndexPath
    
    func test_heightForRowAtIndexPath_shouldReturnAutomaticDimension() {
        // Given
        let viewModel = TableViewModel()
        let tableView = UITableView()
        let section = TableSection()
        let cellViewModel = TableCellViewModel()
        section.items = [cellViewModel]
        viewModel.sections = [section]
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        let result = viewModel.tableView(tableView,
                                         heightForRowAt: indexPath)
        
        
        // Then
        XCTAssertEqual(result, UITableView.automaticDimension)
    }
    
    func test_heightForRowAtIndexPath_shouldReturn0() {
        // Given
        let viewModel = self.viewModelEmptyToTest()
        let tableView = UITableView()
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        let result = viewModel.tableView(tableView,
                                         heightForRowAt: indexPath)
        
        
        // Then
        XCTAssertEqual(result, 0)
    }
    
    // MARK: - estimatedHeightForRowAtIndexPath
    func test_estimatedHeightForRowAtIndexPath_shouldReturnAutomaticDimension() {
        // Given
        let viewModel = TableViewModel()
        let tableView = UITableView()
        let section = TableSection()
        let cellViewModel = TableCellViewModel()
        section.items = [cellViewModel]
        viewModel.sections = [section]
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        let result = viewModel.tableView(tableView,
                                         estimatedHeightForRowAt: indexPath)
        
        // Then
        XCTAssertEqual(result, UITableView.automaticDimension)
    }
    
    // MARK: - didSelectRowAtIndexPath
    func test_didSelectRowAtIndexPath_shouldCallDidSelectOnItem() {
        // Given
        let viewModel = TableViewModel()
        let mockDelegate = MockTableViewModelDelegate()
        viewModel.delegate = mockDelegate
        let cellViewModel = MockTableCellViewModel()
        let firstSection = TableSection()
        firstSection.items = [cellViewModel, cellViewModel]
        viewModel.sections = [firstSection]
        let tableView = UITableView()
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        viewModel.tableView(tableView,
                            didSelectRowAt: indexPath)
        
        // Then
        XCTAssert(cellViewModel.didSelectCalled)
    }
    
    // MARK: - didEndDisplayingCell
    func test_didEndDisplayingCell_shouldNotCrash_whenTryingToAccessSectionInEmptyArray() {
        // Given
        let viewModel = TableViewModel()
        let tableView = UITableView()
        let cell = UITableViewCell()
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When & Then
        viewModel.tableView(tableView,
                            didEndDisplaying: cell,
                            forRowAt: indexPath)
    }
    
    // MARK: - registerCellsOnTableView
    func test_registerCellsOnTableView_shouldCallRegisterCellOnItem() {
        // Given
        let viewModel = TableViewModel()
        let cellViewModel = MockTableCellViewModel()
        let firstSection = TableSection()
        firstSection.items = [cellViewModel, cellViewModel]
        viewModel.sections = [firstSection]
        let tableView = UITableView()
        
        // When
        viewModel.registerCells(tableView: tableView)
        
        // Then
        XCTAssert(cellViewModel.registerCellCalled)
    }
    
    // MARK: - Helper Method
    func viewModelToTestWithItems() -> TableViewModel {
        let viewModel = TableViewModel()
        let item = TableCellViewModel()
        let firstSection = TableSection()
        firstSection.items = [item, item]
        let secondSection = TableSection()
        secondSection.items = [item]
        viewModel.sections = [firstSection, secondSection]
        return viewModel
    }
    
    func viewModelEmptyToTest() -> TableViewModel {
        let viewModel = TableViewModel()
        let item = TableCellViewModel()
        let firstSection = TableSection()
        firstSection.items = []
        let secondSection = TableSection()
        secondSection.items = [item]
        viewModel.sections = []
        return viewModel
    }

}
