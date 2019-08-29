//
//  ForecastDetailVMTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class ForecastDetailVMTests: TestCase {

    // MARK: - title
    func test_title_shouldReturnCorrectText() {
        // Given
        let viewModel = self.viewModelToTest()
        viewModel.forecast.name = "Paris"
        
        // When
        let title = viewModel.title
        
        // Then
        XCTAssertEqual(title, viewModel.forecast.name)
    }
    
    // MARK: - Init
    func test_init_shouldSetProperties() {
        // Given
        let forecast = Forecast()
        let unitFormatIsImperial = false
        
        // When
        let viewModel = ForecastDetailVM(forecast: forecast, unitFormatIsImperial: unitFormatIsImperial)
        
        // Then
        XCTAssertEqual(viewModel.forecast, forecast)
        XCTAssertEqual(viewModel.unitFormatIsImperial, unitFormatIsImperial)
    }
    
    // MARK: - load
    func test_load_shouldConfigureSection_callDelegate_setFiltering_andStoreRepos() {
        // Given
        let viewModel = self.viewModelToTest()
        let delegate = MockTableViewModelDelegate()
        viewModel.delegate = delegate
        let aForecast = Forecast()
        let forecasts = [aForecast]
        self.database.mockGetAll = Result.success(forecasts)
        
        // When
        viewModel.load()
        
        // Then
        XCTAssertEqual(viewModel.sections.count, 1)
        XCTAssert(delegate.viewModelDidStartLoadCalled)
    }
    
    // MARK: - loadSections
    func test_loadSections_shouldConfigureSectionByAddingItems() {
        // Given
        let viewModel = self.viewModelToTest()
        
        let weather = Weather()
        weather.description = "bla"
        viewModel.forecast.weathers = [weather]
        
        let sunInfo = SunInfo()
        sunInfo.sunset = Date()
        sunInfo.sunrise = Date()
        viewModel.forecast.sunInfo = sunInfo
        
        let wind = Wind()
        wind.speed = 65
        viewModel.forecast.wind = wind
        
        let mainInfo = ForecastMainInfo()
        mainInfo.tempMin = 25
        mainInfo.tempMax = 55
        mainInfo.humidity = 45
        viewModel.forecast.forecastMainInfo = mainInfo
        
        // When
        viewModel.loadSections()
        
        // Then
        XCTAssertEqual(viewModel.sections.count, 1)
        XCTAssertEqual(viewModel.sections.first?.items.count, 8)
    }
    
    // MARK: - Helper
    func viewModelToTest() -> ForecastDetailVM {
        let forecast = Forecast()
        let unitFormatIsImperial = false
        let viewModel = ForecastDetailVM(forecast: forecast, unitFormatIsImperial: unitFormatIsImperial)
        return viewModel
    }
    
}
