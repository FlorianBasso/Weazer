//
//  MyForecastsVMTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class MyForecastsVMTests: TestCase {

    // MARK: - isFiltering
    func test_isFiltering_shouldReturnFalse() {
        // Given
        let viewModel = MyForecastsVM()
        
        // When
        let isFiltering = viewModel.isFiltering
        
        // Then
        XCTAssertFalse(isFiltering)
    }
    
    // MARK: - databaseForecasts
    func test_databaseForecasts_shouldNeverBeNil() {
        // Given
        let viewModel = MyForecastsVM()
        
        // When
        let databaseForecasts = viewModel.databaseForecasts
        
        // Then
        XCTAssertNotNil(databaseForecasts)
        XCTAssertEqual(databaseForecasts.count, 0)
    }
    
    // MARK: - filteredForecasts
    func test_filteredForecasts_shouldNeverBeNil() {
        // Given
        let viewModel = MyForecastsVM()
        
        // When
        let filteredForecasts = viewModel.filteredForecasts
        
        // Then
        XCTAssertNotNil(filteredForecasts)
        XCTAssertEqual(filteredForecasts.count, 0)
    }
    
    // MARK: - unitFormatIsImperial
    func test_unitFormatIsImperial_shouldReturnTrueByDefault() {
        // Given
        let viewModel = MyForecastsVM()
        
        // When
        let unitFormatIsImperial = viewModel.unitFormatIsImperial
        
        // Then
        XCTAssert(unitFormatIsImperial)
    }
    
    // MARK: - title
    func test_title_shouldReturnCorrectText() {
        // Given
        let viewModel = MyForecastsVM()
        
        // When
        let title = viewModel.title
        
        // Then
        XCTAssertEqual(title, NSLocalizedString("my.forecasts.title", comment: ""))
    }
    
    // MARK: - searchBarPlaceholder
    func test_searchBarPlaceholder_shouldReturnCorrectText() {
        // Given
        let viewModel = MyForecastsVM()
        
        // When
        let searchBarPlaceholder = viewModel.searchBarPlaceholder
        
        // Then
        XCTAssertEqual(searchBarPlaceholder, NSLocalizedString("my.forecasts.search.placeholder", comment: ""))
    }
    
    // MARK: - load
    func test_load_shouldConfigureSection_callDelegate_setFiltering_andStoreRepos() {
        // Given
        let viewModel = MyForecastsVM()
        let delegate = MockTableViewModelDelegate()
        viewModel.delegate = delegate
        let aForecast = Forecast()
        let forecasts = [aForecast]
        self.database.mockGetAll = Result.success(forecasts)
        
        // When
        viewModel.load()
        
        // Then
        XCTAssertEqual(viewModel.databaseForecasts, forecasts)
        XCTAssertFalse(viewModel.isFiltering)
        XCTAssertEqual(viewModel.sections.count, 1)
        XCTAssert(delegate.viewModelDidStartLoadCalled)
    }
    
    // MARK: - displayAddCitiesScreen
    func test_displayAddCitiesScreen_shouldRouteToAddForecastsRoutingEntry() {
        // Given
        let viewModel = MyForecastsVM()
        
        // When
        viewModel.displayAddCitiesScreen()
        
        // Then
        XCTAssert(self.routing.lastRoutingEntry is AddForecastsRoutingEntry)
    }
    
    // MARK: - filterContentForSearchText
    func test_filterContentForSearchText_shouldReloadSection_setFiltering() {
        // Given
        let viewModel = MyForecastsVM()
        let delegate = MockTableViewModelDelegate()
        viewModel.delegate = delegate
        let searchText = "bla"
        
        let forecast = Forecast()
        forecast.cityName = searchText
        viewModel.databaseForecasts.append(forecast)
        
        // When
        viewModel.filterContentForSearchText(searchText)
        
        // Then
        XCTAssert(viewModel.isFiltering)
        XCTAssertEqual(viewModel.databaseForecasts.count, viewModel.filteredForecasts.count)
        XCTAssertEqual(viewModel.sections.count, 1)
        XCTAssert(delegate.viewModelDidLoadCalled)
    }
    
    // MARK: - didFinishSearch
    func test_didFinishSearch_shouldReloadSection_andSetFiltering() {
        // Given
        let viewModel = MyForecastsVM()
        let delegate = MockTableViewModelDelegate()
        viewModel.delegate = delegate
        
        // When
        viewModel.didFinishSearch()
        
        // Then
        XCTAssertFalse(viewModel.isFiltering)
        XCTAssertEqual(viewModel.sections.count, 0)
        XCTAssert(delegate.viewModelDidLoadCalled)
    }
    
    // MARK: - convertUnitsFormat
    func test_convertUnitsFormat_shouldReloadSection_andUpdateUnitFormatIsImperial() {
        // Given
        let viewModel = MyForecastsVM()
        let delegate = MockTableViewModelDelegate()
        viewModel.delegate = delegate
        
        // When
        viewModel.convertUnitsFormat()
        
        // Then
        XCTAssertFalse(viewModel.unitFormatIsImperial)        
        XCTAssert(delegate.viewModelDidLoadCalled)
    }
    
}
