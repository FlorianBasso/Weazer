//
//  ScrollableViewModelTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class ScrollableViewModelTests: TestCase {
    
    // MARK: - sections
    func test_sections_shouldNeverBeNil_andReturnEmptyArray() {
        // Given
        let scrollViewModel = ScrollableViewModel()
        
        // When
        let sections = scrollViewModel.sections
        
        // Then
        XCTAssertNotNil(sections)
        XCTAssert(sections.count == 0)
    }
    
    // MARK: - load
    func test_load_shouldCallViewModelDidStartLoad() {
        // Given
        let scrollViewModel = ScrollableViewModel()
        let delegate = MockTableViewModelDelegate()
        scrollViewModel.delegate = delegate
        
        // When
        scrollViewModel.load()
        
        // Then
        XCTAssert(delegate.viewModelDidStartLoadCalled)
    }
    
    // MARK: - configurePositionOnSections
    func test_configurePositionOnSections_shouldSetPositionOnEachSections() {
        // Given
        let scrollViewModel = ScrollableViewModel()
        let section1 = Section()
        let section2 = Section()
        scrollViewModel.sections = [section1, section2]
        
        // When
        scrollViewModel.configurePositionOnSections()
        
        // Then
        XCTAssert(section1.position == 0)
        XCTAssert(section2.position == 1)
    }
    
    // MARK: - handleSuccess
    func test_handleSuccess_shouldLoadSections_setPositionOnEachSections_resetEmptyReason_andCallViewModelDidLoad() {
        // Given
        let scrollViewModel = ScrollableViewModel()
        let section1 = Section()
        let section2 = Section()
        scrollViewModel.sections = [section1, section2]
        let delegate = MockTableViewModelDelegate()
        scrollViewModel.delegate = delegate
        
        // When
        scrollViewModel.handleSuccess()
        
        // Then
        XCTAssert(section1.position == 0)
        XCTAssert(section2.position == 1)
        XCTAssert(delegate.viewModelDidLoadCalled)
    }
    
    // MARK: - handleFailureWithStatusCode
    func test_handleFailureWithStatusCode_shouldCallViewModelDidFail_whenThereIsNoSections_andSetCorrectEmptyReason() {
        // Given
        let scrollViewModel = ScrollableViewModel()
        let delegate = MockTableViewModelDelegate()
        scrollViewModel.delegate = delegate
        let statusCode = 500
        let error = NSError(domain: "domain", code: 0, userInfo: nil)
        
        // When
        scrollViewModel.handleFailure(withStatusCode: statusCode,
                                      error: error)
        
        // Then
        XCTAssert(delegate.viewModelDidFailCalled)
    }

}
