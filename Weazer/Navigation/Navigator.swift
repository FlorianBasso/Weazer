//
//  Navigator.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import UIKit

protocol Navigator {
    var lastNavigationStyle: NavigationStyle? { get set }
    func visibleViewController() -> UIViewController?
    func visibleViewController(_ rootViewController: UIViewController?) -> UIViewController?
    func route(navigationStyle: NavigationStyle, animated: Bool) -> Navigator
}
