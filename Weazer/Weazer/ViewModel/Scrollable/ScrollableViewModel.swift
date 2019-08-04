//
//  ScrollableViewModel.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import UIKit

class ScrollableViewModel: NSObject, ViewModel {
    
    // MARK: - Properties
    public lazy var sections = [Section]()
    var title: String?
    var leftBarButtonItem: UIBarButtonItem?
    var rightBarButtonItem: UIBarButtonItem?
    weak var delegate: ViewModelDelegate?
    
    // MARK: - Load
    
    open func viewDidLoad(viewController: UIViewController) {
        // Override in subclasses
    }
    
    open func load() {
        self.delegate?.viewModelDidStartLoad()
    }
    
    open func loadSections() {
        // Override in subclasses and call super
        
    }
    
    func configurePositionOnSections() {
        for index in 0..<self.sections.count {
            self.sections[index].position = index
        }
    }
    
    // MARK: - Success
    open func handleSuccess() {
        self.loadSections()
        self.configurePositionOnSections()
        self.delegate?.viewModelDidLoad()
    }
    
    // MARK: - Failure
    
    open func handleFailure(withStatusCode statusCode: Int, error: Error?) {
        // Avoid to show the error message if the feed already contains recipes
        if self.sections.count == 0 {
            self.delegate?.viewModelDidFail(statusCode: statusCode)
        }
    }
    
}
