//
//  PopRoutingEntry.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import UIKit

class PopRoutingEntry: RoutingEntry {
    
    var url: String?        
    var viewController: UIViewController?
    var animated: Bool = true
    var completionBlock: (() -> Void)?
    
    var navigationStyle: NavigationStyle {
        return .pop
    }
    
}
