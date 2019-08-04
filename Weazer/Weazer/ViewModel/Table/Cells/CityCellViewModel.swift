//
//  CityCellViewModel.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import UIKit

class CityCellViewModel: TableCellViewModel {

    // MARK: - Properties
    var cityName: String
    
    // MARK: - Init
    init(cityName: String) {
        self.cityName = cityName
    }
    
    // MARK: - TableCellViewModel
    
    override func willDisplay(_ cell: UITableViewCell) {
        // City Name
        cell.textLabel?.text = self.cityName
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear                
    }
    
    // MARK: - TableCellViewModel
    override func didSelect(fromVC: UIViewController?) {
        
        // Calls API to get forecast for city
        let endpoint = GetCurrentWeatherDataEndpoint(cityName: self.cityName,
                                                     coordinate: nil)
        AppEnvironment.shared().api?.request(with: endpoint, success: { (responseObject) in
            
            if let forecast = responseObject as? Forecast {
                // Save forecast on database
                AppEnvironment.shared().database?.insertOrUpdate(item: forecast)
            }
            
            // Pop to previous screen
            AppEnvironment.shared().routing?.route(to: PopRoutingEntry(), from: fromVC)
        }, failure: { (operation, error, statusCode) in
            // TODO: Handles error
        })
    }
    
}
