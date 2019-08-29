//
//  GetSearchRepoEndpoint.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

class GetCurrentWeatherDataEndpoint: APIEndpoint {
    
    typealias Response = Forecast
    
    // MARK: - Properties
    struct Constants {
        static let query = "q"
        static let appId = "APPID"
        static let latitude = "lat"
        static let longitude = "lon"
        static let imperial = "imperial"
        static let units = "units"
        static let lang = "lang"
    }
    
    var path: String {
        return "weather"
    }
    
    var method: APIMethod {
        return .get
    }
    
    var entryParameters: [String : Any]? {
        
        var parameters: [String : Any] = [Constants.appId: "c3d25de6aa2d5fa2c7fa3232cb8a7429",
                                               Constants.units: Constants.imperial]
        
        if let cityName = self.cityName {
            parameters[Constants.query] = cityName
        }
        
        if let coordinate = self.coordinate {
            parameters[Constants.latitude] = coordinate.lat
            parameters[Constants.longitude] = coordinate.long
        }
        
        if let language = Bundle.main.preferredLocalizations.first {
            parameters[Constants.lang] = language
        }
        
        return parameters
    }
    
    var cityName: String?
    var coordinate: (lat: Double, long: Double)?
    
    // MARK: - Init
    init(cityName: String?,
         coordinate: (lat: Double, long: Double)?) {
        self.cityName = cityName
        self.coordinate = coordinate
    }
    
    // MARK: - Parsing
    func parsing(responseObject: Data?) -> Result<Forecast, APIError> {
        
        guard let data = responseObject else {
            return Result.failure(.parsingError)
        }
        
        do {            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let forecast = try decoder.decode(Forecast.self, from: data)
            return Result.success(forecast)
        } catch {
            return Result.failure(.parsingError)
        }
    }
    
    // MARK: - Error
    func errorMessage(statusCode: Int) -> String {
        return ""
    }
    
}
