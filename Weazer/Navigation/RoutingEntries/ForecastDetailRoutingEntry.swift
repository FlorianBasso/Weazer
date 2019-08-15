//
//  ForecastDetailRoutingEntry.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import UIKit

class ForecastDetailRoutingEntry: RoutingEntry {
    
    // MARK: - Properties
    let forecast: Forecast
    var unitFormatIsImperial: Bool
    var completionBlock: (() -> Void)?
    var viewController: UIViewController? {
        let viewModel = ForecastDetailVM(forecast: self.forecast,
                                         unitFormatIsImperial: self.unitFormatIsImperial)
        let forecastsTVC = ForecastsTVC(viewModel: viewModel)
        return forecastsTVC
    }
            
    // MARK: - Init
    init(forecast: Forecast, unitFormatIsImperial: Bool) {
        self.forecast = forecast
        self.unitFormatIsImperial = unitFormatIsImperial
    }
    
}
