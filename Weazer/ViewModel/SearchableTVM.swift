//
//  SearchableTVM.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import UIKit

class SearchableTVM: TableViewModel {
    
    // MARK: - Properties
    
    var searchController: UISearchController?
        
    var searchBarPlaceholder: String? {
        return nil
    }
    
    // MARK: - Search
    
    func filterContentForSearchText(_ searchText: String) {
        // Overrides in subclasses
    }
    
    func didFinishSearch() {
        // Overrides in subclasses
    }
    
    func configureSearchController(viewController: UIViewController) {
        // Create the search results controller and store a reference to it.
        // We will display the result on this current controller, so we put nil for the results controller
        self.searchController = UISearchController(searchResultsController: nil)
        
        self.searchController?.searchBar.barTintColor = .clear
        self.searchController?.searchBar.isTranslucent = false
        self.searchController?.searchBar.tintColor = .white
        self.searchController?.searchBar.searchBarStyle = .minimal
        self.searchController?.searchBar.searchTextField.textColor = .white
        
        
        // Use the current view controller to update the search results.
        self.searchController?.searchResultsUpdater = self
        self.searchController?.searchBar.placeholder = self.searchBarPlaceholder
        
        // Install the search bar as the table header.
        if let tableVC = viewController as? UITableViewController {
            tableVC.tableView.tableHeaderView = self.searchController?.searchBar
        }
        
        // It is usually good to set the presentation context.
        viewController.definesPresentationContext = true
        
        // Avoid to obscure background when showing search screen
        self.searchController?.obscuresBackgroundDuringPresentation = false
        
        // Sets self as delegate to the search controller
        self.searchController?.delegate = self
    }
    
    // MARK: - Load
    override func viewDidLoad(viewController: UIViewController) {
        self.configureSearchController(viewController: viewController)
    }
        
    // MARK: - Sections
    
    override func loadSections() {
        super.loadSections()
        self.sections.removeAll()
        
        let section = self.sectionToAdd()
        if section.items.count > 0 {
            self.sections.append(section)
        }        
    }
    
    func sectionToAdd() -> TableSection {
        // Override in subclasses
        return TableSection()
    }
    
}

// MARK: UISearchResultsUpdating
extension SearchableTVM: UISearchResultsUpdating {
    
    // Called when the search bar's text or scope has changed or when the search bar becomes first responder.
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text,
            searchText.count > 0 else {
            return
        }
        self.filterContentForSearchText(searchText)
    }
}

// MARK: - UISearchControllerDelegate
extension SearchableTVM: UISearchControllerDelegate {
    
    func didDismissSearchController(_ searchController: UISearchController) {
        self.didFinishSearch()
    }
    
}
