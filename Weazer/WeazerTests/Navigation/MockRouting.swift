//
//  MockRouting.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import UIKit
@testable import Weazer

class MockRouting: Navigator {
    
    var lastRoutingEntry: RoutingEntry?
    
    var mockVisibleViewController = UIViewController()
    
    func visibleViewController() -> UIViewController? {
        return mockVisibleViewController
    }
    
    func visibleViewController(_ rootViewController: UIViewController?) -> UIViewController? {
        return mockVisibleViewController
    }
    
    func route(to entry: RoutingEntry) {
        self.route(to: entry, from: nil)
    }
    
    func route(to entry: RoutingEntry, from fromViewController: UIViewController?) {
        self.lastRoutingEntry = entry
        entry.completionBlock?()
    }
}
