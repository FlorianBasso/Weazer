//
//  NavigationStyle.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import UIKit

protocol NavigationStyle {
    
    func navigate(animated: Bool)
}

struct PushNavigationStyle: NavigationStyle {
    
    let fromNVC: UINavigationController
    var routingEntry: RoutingEntry?
    
    init(fromNVC: UINavigationController,
         routingEntry: RoutingEntry) {
        self.fromNVC = fromNVC
        self.routingEntry = routingEntry
    }
    
    func navigate(animated: Bool) {
        guard let toVC = self.routingEntry?.viewController else { return }
        self.fromNVC.pushViewController(toVC, animated: animated)
    }
}

struct PopNavigationStyle: NavigationStyle {
    
    let fromNVC: UINavigationController
    
    init(fromNVC: UINavigationController) {
        self.fromNVC = fromNVC
    }
    
    func navigate(animated: Bool) {
        fromNVC.popViewController(animated: animated)
    }        
}

struct ModalNavigationStyle: NavigationStyle {
    
    let fromVC: UIViewController
    var routingEntry: RoutingEntry?
    
    init(fromVC: UIViewController,
         routingEntry: RoutingEntry) {
        self.fromVC = fromVC
        self.routingEntry = routingEntry
    }
    
    func navigate(animated: Bool) {
        if let toVC = self.routingEntry?.viewController {
            self.fromVC.present(toVC,
                                animated: animated,
                                completion: {() -> Void in
                                    self.routingEntry?.completionBlock?()
            })
        }
    }
}

struct DismissNavigationStyle: NavigationStyle {
    
    let fromVC: UIViewController
    var routingEntry: RoutingEntry?
    
    init(fromVC: UIViewController,
         routingEntry: RoutingEntry) {
        self.fromVC = fromVC
        self.routingEntry = routingEntry
    }
    
    func navigate(animated: Bool) {
        self.fromVC.dismiss(animated: animated, completion: {() -> Void in
            self.routingEntry?.completionBlock?()
        })
    }
}

struct URLNavigationStyle: NavigationStyle {
    
    let urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func navigate(animated: Bool) {
        if let finalUrl = URL(string: self.urlString),
            UIApplication.shared.canOpenURL(finalUrl) {
            UIApplication.shared.open(finalUrl,
                                      options: [:],
                                      completionHandler: nil)            
        }
    }
}

