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
    
    var lastRoutingEntry: RoutingEntry?
    
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
    
    func route(to entry: RoutingEntry) {
        self.route(to: entry, from: nil)
    }
    
    func route(to entry: RoutingEntry, from fromViewController: UIViewController?) {
        
        var fromVC = fromViewController
        
        if fromVC == nil {
            fromVC = self.visibleViewController()
        }
        
        let viewControllerToDisplay = entry.viewController
        let animated: Bool = entry.animated
        let url = entry.url
        
        // Navigate on main thread to avoid crashes
        DispatchQueue.main.async(execute: {() -> Void in
            switch entry.navigationStyle {
            case .push:
                
                var fromNavigationController: UINavigationController? = fromVC as? UINavigationController
                
                if let navigationController = fromVC?.navigationController {
                    fromNavigationController = navigationController
                }
                if let aDisplay = viewControllerToDisplay {
                    fromNavigationController?.pushViewController(aDisplay, animated: animated)
                }
                
                break
                
            case .pop:
                fromVC?.navigationController?.popViewController(animated: animated)
                break
                
            case .modal:
                if let aDisplay = viewControllerToDisplay {
                    fromVC?.present(aDisplay, animated: animated,
                                    completion: {() -> Void in
                                        entry.completionBlock?()
                    })
                }
                
                break
                
            case .dismiss:
                fromVC?.dismiss(animated: animated, completion: {() -> Void in
                    entry.completionBlock?()
                })
                break
            
            case .openUrl:
                if let anUrlString = url,
                    let finalUrl = URL(string: anUrlString) {
                    if UIApplication.shared.canOpenURL(finalUrl) {
                        UIApplication.shared.open(finalUrl,
                                                  options: [:],
                                                  completionHandler: nil)
                    }
                }
                break
            }
        })
        
    }
    
}
