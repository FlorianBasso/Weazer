//
//  ForecastCellViewModel.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import UIKit

class ForecastCellViewModel: TableCellViewModel {

    // MARK: - Properties
    var forecast: Forecast
    var unitFormatIsImperial: Bool
    var shouldHandleSelection: Bool
    
    // MARK: - Init
    init(forecast: Forecast,
         unitFormatIsImperial: Bool,
         shouldHandleSelection: Bool = false) {
        self.forecast = forecast
        self.unitFormatIsImperial = unitFormatIsImperial
        self.shouldHandleSelection = shouldHandleSelection
    }
    
    // MARK: - TableCellViewModel
    override var reuseIdentifier: String {
        return String(describing: ForecastCell.self)        
    }
    
    override func cellHeight(_ maxSize: CGSize) -> CGFloat {
        return 100
    }
    
    override func willDisplay(_ cell: UITableViewCell) {
        guard let forecastCell = cell as? ForecastCell else {
            return
        }
        
        // City Name
        forecastCell.cityNameLabel.text = self.forecast.name
        
        // Temperature
        if let temp = self.forecast.forecastMainInfo?.temp {
            forecastCell.tempLabel.text = TempFormatter.tempText(unitFormatIsImperial: self.unitFormatIsImperial,
                                                                 temp: temp)
        }
        
        // Location Image View
        forecastCell.locationImageView.isHidden = !self.forecast.forUserPosition
        forecastCell.locationImageView.tintColor = UIColor(white: 1, alpha: 1.0)
        
        // Icon Image View
        if let imageManager = AppEnvironment.shared().imageManager,
            let iconName = self.forecast.weathers?.first?.icon {
            
            let url = imageManager.url(icon: iconName)            
            imageManager.setImageWith(url,
                                      on: forecastCell.iconImageView,
                                      placeholderImage: nil,
                                      completed: nil)
        }
        
    }
    
    override func didSelect(fromVC: UIViewController?) {
        if self.shouldHandleSelection {
            
            guard let fromVNC = fromVC?.navigationController else {
                return
            }
            
            // Redirect to forecast detailed screen
            let detailRoutingEntry = ForecastDetailRoutingEntry(forecast: self.forecast,
                                                                unitFormatIsImperial: self.unitFormatIsImperial)
            
            let pushNavStyle = PushNavigationStyle(fromNVC: fromVNC,
                                                   routingEntry: detailRoutingEntry)
                        
            _ = AppEnvironment.shared().routing?.route(navigationStyle: pushNavStyle,
                                                       animated: true)
        }        
    }
    
}
