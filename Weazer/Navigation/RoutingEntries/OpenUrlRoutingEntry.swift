//
//  OpenUrlRoutingEntry.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import UIKit

class OpenUrlRoutingEntry: RoutingEntry {
    
    var viewController: UIViewController?
    var animated: Bool = true
    var completionBlock: (() -> Void)?
    
    let externUrl: String
    
    // MARK: - Initialization
    
    init(url: String) {
        self.externUrl = url
    }
    
    // MARK: - YMMRoutingEntry
    
    var navigationStyle: NavigationStyle {
        return .openUrl
    }
    
     var url: String? {
        return self.externUrl
    }
}
