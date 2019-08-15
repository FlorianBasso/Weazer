//
//  AddForecastsRoutingEntry.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import UIKit

class AddForecastsRoutingEntry: RoutingEntry {
            
    var viewController: UIViewController? {
        let addCitiesVM = AddForecastsVM()
        let forecastsTVC = ForecastsTVC(viewModel: addCitiesVM)
        return forecastsTVC
    }
    
    var completionBlock: (() -> Void)?
    
}
