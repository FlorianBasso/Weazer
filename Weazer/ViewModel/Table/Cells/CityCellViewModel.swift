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
        
        guard let api = AppEnvironment.shared().api else {
            return
        }
        
        api.asyncCall(thread: .utility) {
            let result = api.request(with: endpoint, resultType: Forecast.self)                
            
            do {
                let forecast = try result.get()
                // Save forecast on database
                _ = AppEnvironment.shared().database?.insertOrUpdate(item: forecast)
                
                
                // Pop to previous screen
                guard let fromNVC = fromVC?.navigationController else {
                        return
                }
                
                let popNavStyle = PopNavigationStyle(fromNVC: fromNVC)
                _ = AppEnvironment.shared().routing?.route(navigationStyle: popNavStyle, animated: true)                                      
            }
            catch {
                // TODO: Handles error
            }
        }
        
    }
    
}
