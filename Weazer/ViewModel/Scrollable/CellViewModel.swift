//
//  CellViewModel.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import UIKit

class CellViewModel: NSObject {
    
    // MARK: - Properties
    var routingEntry: RoutingEntry?
    var indexPath: IndexPath?
    
    var reuseIdentifier: String {
        return ""
    }
    
    var bundleForNib: Bundle {
        return Bundle(for: type(of: self))
    }
    
    var cellNib: UINib? {
        if self.reuseIdentifier.count > 0 {
            return UINib(nibName: self.reuseIdentifier,
                         bundle: self.bundleForNib)
        }
        
        return nil
    }
    
    // MARK: - Methods
    func didSelect(fromVC: UIViewController?) {
        // Nothing by default
    }
}
