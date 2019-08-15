//
//  GetCurrentWeatherDataEndpointTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class GetCurrentWeatherDataEndpointTests: TestCase {
   
    // MARK: - query
    func test_query_shouldReturnCorrectText() {
        // Given & When
        let query = GetCurrentWeatherDataEndpoint.Constants.query
        
        // Then
        XCTAssertEqual(query, "q")
    }
    
    // MARK: - appId
    func test_appId_shouldReturnCorrectText() {
        // Given & When
        let appId = GetCurrentWeatherDataEndpoint.Constants.appId
        
        // Then
        XCTAssertEqual(appId, "APPID")
    }
    
    // MARK: - latitude
    func test_latitude_shouldReturnCorrectText() {
        // Given & When
        let latitude = GetCurrentWeatherDataEndpoint.Constants.latitude
        
        // Then
        XCTAssertEqual(latitude, "lat")
    }
    
    // MARK: - longitude
    func test_longitude_shouldReturnCorrectText() {
        // Given & When
        let longitude = GetCurrentWeatherDataEndpoint.Constants.longitude
        
        // Then
        XCTAssertEqual(longitude, "lon")
    }
    
    // MARK: - imperial
    func test_imperial_shouldReturnCorrectText() {
        // Given & When
        let imperial = GetCurrentWeatherDataEndpoint.Constants.imperial
        
        // Then
        XCTAssertEqual(imperial, "imperial")
    }
    
    // MARK: - units
    func test_units_shouldReturnCorrectText() {
        // Given & When
        let units = GetCurrentWeatherDataEndpoint.Constants.units
        
        // Then
        XCTAssertEqual(units, "units")
    }
    
    // MARK: - lang
    func test_lang_shouldReturnCorrectText() {
        // Given & When
        let lang = GetCurrentWeatherDataEndpoint.Constants.lang
        
        // Then
        XCTAssertEqual(lang, "lang")
    }
    
    // MARK: - path
    func test_path_shouldReturnCorrectText() {
        // Given
        let endpoint = GetCurrentWeatherDataEndpoint(cityName: nil, coordinate: nil)
        
        // When
        let path = endpoint.path
        
        // Then
        XCTAssertEqual(path, "weather")
    }
    
    // MARK: - method
    func test_method_shouldReturnGet() {
        // Given
        let endpoint = GetCurrentWeatherDataEndpoint(cityName: nil, coordinate: nil)
        
        // When
        let method = endpoint.method
        
        // Then
        XCTAssertEqual(method, .get)
    }
    
    // MARK: - entryParameters
    func test_entryParameters_shouldHaveCorrectParameters() {
        // Given
        let cityName = "Paris"
        let coordinate: (lat: Double, long: Double) = (lat: 20, long: 20)
        let endpoint = GetCurrentWeatherDataEndpoint(cityName: cityName, coordinate: coordinate)
   
        
        // When
        let params = endpoint.entryParameters
        
        // Then
        XCTAssertEqual(params?.count, 6)
        XCTAssertEqual(params?[GetCurrentWeatherDataEndpoint.Constants.appId] as? String, "c3d25de6aa2d5fa2c7fa3232cb8a7429")
        XCTAssertEqual(params?[GetCurrentWeatherDataEndpoint.Constants.units] as? String, GetCurrentWeatherDataEndpoint.Constants.imperial)
        
        XCTAssertEqual(params?[GetCurrentWeatherDataEndpoint.Constants.query] as? String, cityName)
        
        XCTAssertEqual(params?[GetCurrentWeatherDataEndpoint.Constants.latitude] as? Double, coordinate.lat)
        
        XCTAssertEqual(params?[GetCurrentWeatherDataEndpoint.Constants.longitude] as? Double, coordinate.long)
        
        XCTAssertEqual(params?[GetCurrentWeatherDataEndpoint.Constants.lang] as? String, Bundle.main.preferredLocalizations.first)
    }
    
    // MARK: - init
    func test_init_shouldSetProperties() {
        // Given
        let cityName = "Paris"
        let coordinate: (lat: Double, long: Double) = (lat: 20, long: 20)
        
        // When
        let endpoint = GetCurrentWeatherDataEndpoint(cityName: cityName, coordinate: coordinate)
        
        
        // Then
        XCTAssertEqual(endpoint.cityName, cityName)
        XCTAssertEqual(endpoint.coordinate?.lat, coordinate.lat)
        XCTAssertEqual(endpoint.coordinate?.long, coordinate.long)
    }
    
    
    // MARK: - parsingResponseObject
    func test_parsingResponseObject_shouldReturnParsingError_whenJsonIsIncorrect() {
        
        // Given
        let endpoint = GetCurrentWeatherDataEndpoint(cityName: nil, coordinate: nil)
        
        // When
        let result = endpoint.parsing(responseObject: nil)
        
        // Then
        XCTAssertEqual(result, Result.failure(APIError.parsingError))
    }
    
    func test_parsingResponseObject_shouldReturnForecast_whenJsonIsCorrect() {
        // Given
        let endpoint = GetCurrentWeatherDataEndpoint(cityName: nil, coordinate: nil)
        let responseObject: [AnyHashable: Any] = [:]
        
        // When
        let result = endpoint.parsing(responseObject: responseObject)
        
        // Then
        do {
            _ = try result.get()            
        } catch {
            XCTFail()
        }
        
    }
    
}
