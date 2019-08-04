//
//  TableViewModel.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import UIKit

class TableViewModel: ScrollableViewModel {
    
    // MARK: - Properties
    
    public weak var tvDelegate: TableViewModelDelegate? {
        get {
            return self.delegate as? TableViewModelDelegate
        }
        set {}
    }
    
    public var tableFooterView: UIView?
    
    // MARK: - Register
    public func registerCells(tableView: UITableView) {
        guard let sections = self.sections as? [TableSection] else { return }
        
        for section in sections {
            guard let items = section.items as? [TableCellViewModel] else { return }
            
            for item in items {
                item.registerCell(tableView)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension TableViewModel: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.sections.count > section,
            let currentSection = self.sections[section] as? TableSection {
            return currentSection.items.count
        } else {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: .default, reuseIdentifier: "")
        
        if self.sections.count > 0 && self.sections.count > indexPath.section {
            
            if let currentSection = self.sections[indexPath.section] as? TableSection,
                let item = currentSection.items[indexPath.row] as? TableCellViewModel {
                item.indexPath = indexPath
                let reuseIdentifier = item.reuseIdentifier
                
                if reuseIdentifier == String(describing:UITableViewCell.self) {
                    cell = UITableViewCell(style: .value1,
                                           reuseIdentifier: reuseIdentifier)
                } else {
                    cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
                }
                
                item.configureCell(cell)
            }
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TableViewModel: UITableViewDelegate {       
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.sections.count > 0 && self.sections.count > indexPath.section {
            
            if let currentSection = self.sections[indexPath.section] as? TableSection,
                let item = currentSection.items[indexPath.row] as? TableCellViewModel {                
                return item.cellHeight(tableView.frame.size)
            }
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.sections.count > 0 && self.sections.count > indexPath.section {
            
            if let currentSection = self.sections[indexPath.section] as? TableSection,
                let item = currentSection.items[indexPath.row] as? TableCellViewModel {
                
                return item.estimatedHeight()
            }
        }
        return 0
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Override this method to do something special when a cell is Selected
        
        if self.sections.count > 0 && self.sections.count > indexPath.section {
            if let currentSection = self.sections[indexPath.section] as? TableSection,
                let item = currentSection.items[indexPath.row] as? TableCellViewModel,
                let vc = self.delegate as? UIViewController  {
                item.didSelect(fromVC: vc)
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if self.sections.count > 0 && self.sections.count > indexPath.section && self.tableView(tableView, numberOfRowsInSection: indexPath.section) > 0 {
            
            if let currentSection = self.sections[indexPath.section] as? TableSection {
                
                if currentSection.items.count > 0 && currentSection.items.count > indexPath.row,
                    let item = currentSection.items[indexPath.row] as? TableCellViewModel {
                    item.willDisplay(cell)
                }
            }
        }
        
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if self.sections.count > 0 && self.sections.count > indexPath.section {
            
            if let currentSection = self.sections[indexPath.section] as? TableSection {
                
                if currentSection.items.count > 0 && currentSection.items.count > indexPath.row,
                    let item = currentSection.items[indexPath.row] as? TableCellViewModel {
                    item.didEndDisplaying(cell)
                }
            }
        }
        
    }
    
}
