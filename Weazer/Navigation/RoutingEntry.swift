//
//  RoutingEntry.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import UIKit

protocol RoutingEntry {
    
    var viewController: UIViewController? { get }
    var completionBlock: (() -> Void)? { get set }    
}
