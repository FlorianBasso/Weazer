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
    var title: String
    var info: String
    
    // MARK: - Init
    init(title: String,
         info: String) {
        self.title = title
        self.info = info
    }
    
    // MARK: - TableCellViewModel
    
    override func willDisplay(_ cell: UITableViewCell) {
        cell.backgroundColor = .clear
        
        // Title
        cell.textLabel?.text = self.title
        cell.textLabel?.textColor = .white
        
        // Info
        cell.detailTextLabel?.text = self.info
        cell.detailTextLabel?.textColor = .white                
    }
    
}
