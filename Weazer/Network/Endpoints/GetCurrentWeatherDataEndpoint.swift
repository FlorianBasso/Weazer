//
//  GetSearchRepoEndpoint.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

class GetCurrentWeatherDataEndpoint: APIEndpoint {
    
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
    
    var entryParameters: [AnyHashable : Any]? {
        
        var parameters: [AnyHashable : Any] = [Constants.appId: "c3d25de6aa2d5fa2c7fa3232cb8a7429",
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
    
    func parsing(responseObject: Any?) -> Any? {
        guard let dict = responseObject as? [AnyHashable: Any] else { return nil }
        return Forecast(data: dict)
    }
    
    // MARK: - Error
    func errorMessage(statusCode: Int) -> String {
        return ""
    }
    
}
