//
//  DetailInfoCellViewModel.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import UIKit

class DetailInfoCellViewModel: TableCellViewModel {
    
    // MARK: - Properties
    var forecast: Forecast
    
    // MARK: - Init
    init(forecast: Forecast) {
        self.forecast = forecast
    }
    
    // MARK: - TableCellViewModel
    
    override func willDisplay(_ cell: UITableViewCell) {
        
        
    }
    
}
