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
            
    var lastNavigationStyle: NavigationStyle?
    
    var mockVisibleViewController = UIViewController()
    var visibleVCShouldHaveNavController = false
    
    func visibleViewController() -> UIViewController? {
        
        if visibleVCShouldHaveNavController {
            _ = UINavigationController(rootViewController: mockVisibleViewController)
        }
        
        return mockVisibleViewController
    }
    
    func visibleViewController(_ rootViewController: UIViewController?) -> UIViewController? {
        return visibleViewController()
    }
    
    func route(navigationStyle: NavigationStyle, animated: Bool) -> Navigator {
        self.lastNavigationStyle = navigationStyle
        return self
    }
}
