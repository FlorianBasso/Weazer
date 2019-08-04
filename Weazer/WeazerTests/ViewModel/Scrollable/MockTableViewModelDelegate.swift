//
//  MockTableViewModelDelegate.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import UIKit
@testable import Weazer

class MockTableViewModelDelegate: UIViewController, TableViewModelDelegate {
    
    var viewModel: ViewModel?
    
    var viewModelDidStartLoadCalled = false
    func viewModelDidStartLoad() {
        viewModelDidStartLoadCalled = true
    }
    
    var viewModelDidLoadCalled = false
    func viewModelDidLoad() {
        viewModelDidLoadCalled = true
    }
    
    var viewModelDidFailCalled = false
    func viewModelDidFail(statusCode: Int) {
        viewModelDidFailCalled = true
    }

    
    var reloadVisibleCellsCalled = false
    func reloadVisibleCells() {
        self.reloadVisibleCellsCalled = true
    }
    
    var reloadSectionCalled = false
    func reload(section: TableSection) {
        reloadSectionCalled = true
    }
    
    var reloadRowsCalled = false
    func reloadRows(indexPaths: [IndexPath]) {
        reloadRowsCalled = true
    }
    
    var deleteRowsCalled = false
    func deleteRows(indexPaths: [IndexPath]) {
        deleteRowsCalled = true
    }
    
    var reloadDataViewCalled = false
    func reloadDataView() {
        reloadDataViewCalled = true
    }     
}
