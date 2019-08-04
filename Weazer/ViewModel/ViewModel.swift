//
//  ViewModel.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import UIKit

public protocol ViewModelDelegate: class {
    func viewModelDidStartLoad()
    func viewModelDidLoad()
    func viewModelDidFail(statusCode: Int)
}

protocol ViewModel {
    
    // MARK: - Properties
    var delegate: ViewModelDelegate? { get set }
    var title: String? { get set }
    var rightBarButtonItem: UIBarButtonItem? { get set }
    var leftBarButtonItem: UIBarButtonItem? { get set }
    
    // MARK: - Load
    func viewDidLoad(viewController: UIViewController)
    func load()
    
    // MARK: - Success
    func handleSuccess()
    
    // MARK: - Failure
    func handleFailure(withStatusCode statusCode: Int,
                       error: Error?)
}
