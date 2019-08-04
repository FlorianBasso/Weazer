//
//  TableViewModelDelegate.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

protocol TableViewModelDelegate: ViewModelDelegate {
    
    func reloadVisibleCells()
    func reload(section: TableSection)
    func reloadDataView()
    func deleteRows(indexPaths: [IndexPath])
    func reloadRows(indexPaths: [IndexPath])    
    
}
