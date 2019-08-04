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
    var lastRoutingEntry: RoutingEntry? { get set }
    func visibleViewController() -> UIViewController?
    func visibleViewController(_ rootViewController: UIViewController?) -> UIViewController?
    func route(to entry: RoutingEntry)
    func route(to entry: RoutingEntry, from fromViewController: UIViewController?)
}
