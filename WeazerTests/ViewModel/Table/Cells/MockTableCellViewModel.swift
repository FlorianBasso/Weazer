//
//  MockTableCellViewModel.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import UIKit
@testable import Weazer

class MockTableCellViewModel: TableCellViewModel {
    
    var didSelectCalled = false
    override func didSelect(fromVC fromViewController: UIViewController!) {
        self.didSelectCalled = true
    }
    
    var registerCellCalled = false
    
    override func registerCell(_ tableView: UITableView) {
        self.registerCellCalled = true
    }
    
    override func estimatedHeight() -> CGFloat {
        return 50;
    }
    
    override func cellHeight(_ maxSize: CGSize) -> CGFloat {
        return 50;
    }
}
