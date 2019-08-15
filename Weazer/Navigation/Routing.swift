//
//  Routing.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import UIKit

class Routing: NSObject, Navigator {
    
    // MARK: - Navigator
    
    var lastNavigationStyle: NavigationStyle?
    
    func visibleViewController() -> UIViewController? {
        guard let window = UIApplication.shared.delegate?.window as? UIWindow else {
            return nil
        }
        return self.visibleViewController(window.rootViewController)        
    }
    
    func visibleViewController(_ rootViewController: UIViewController?) -> UIViewController? {
        
        if let rootNavigationController = rootViewController as? UINavigationController {
            let lastViewController: UIViewController? = rootNavigationController.viewControllers.last
            return self.visibleViewController(lastViewController)
        } else if let rootTabBarController = rootViewController as? UITabBarController {
            let selectedViewController: UIViewController? = rootTabBarController.selectedViewController
            return visibleViewController(selectedViewController)
        }
        
        if rootViewController?.presentedViewController == nil {
            return rootViewController
        } else {
            return self.visibleViewController(rootViewController?.presentedViewController)
        }
    }
    
    func route(navigationStyle: NavigationStyle, animated: Bool = true) -> Navigator {
        navigationStyle.navigate(animated: animated)
        self.lastNavigationStyle = navigationStyle
        return self
    }
}
