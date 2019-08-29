//
//  MyForecastsVM.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import UIKit

class MyForecastsVM: SearchableTVM {
    
    // MARK: - Properties
    var isFiltering = false
    lazy var databaseForecasts = [Forecast]()
    lazy var filteredForecasts = [Forecast]()
    var unitFormatIsImperial = true // By default, we use imperial (°F and m/h)
    
    override var title: String? {
        get {
            return NSLocalizedString("my.forecasts.title", comment: "")
        }
        set {}
    }
    
    override var searchBarPlaceholder: String? {
        return NSLocalizedString("my.forecasts.search.placeholder", comment: "")
    }
    
    override var rightBarButtonItem: UIBarButtonItem? {
        get {
            let addReposItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add,
                                               target: self,
                                               action: #selector(displayAddCitiesScreen))
            return addReposItem
        }
        set {}
    }
    
    override var leftBarButtonItem: UIBarButtonItem? {
        get {
            
            let button = UIButton()
            button.setTitle("°C / °F", for: .normal)
            button.sizeToFit()
            
            button.addTarget(self,
                             action: #selector(convertUnitsFormat),
                             for: .touchUpInside)
            
            let leftItem = UIBarButtonItem(customView: button)
            return leftItem
        }
        set {}
    }
    
    // MARK: - Sections
    override func sectionToAdd() -> TableSection {
        
        let section = TableSection()
        
        let forecastsToDisplay = self.isFiltering ? self.filteredForecasts : self.databaseForecasts
        
        for forecast in forecastsToDisplay {
            let repoCVM = ForecastCellViewModel(forecast: forecast,
                                                unitFormatIsImperial: self.unitFormatIsImperial,
                                                shouldHandleSelection: true)
            section.items.append(repoCVM)
        }
        
        return section
    }
    
    // MARK: - Load
    override func load() {
        super.load()
        // Fetch repo in database
        guard let result = AppEnvironment.shared().database?.getAll(type: Forecast.self) else {
            return
        }
        
        switch result {
        case .success(let databaseForecasts):
            self.databaseForecasts = databaseForecasts
            self.isFiltering = false
            self.handleSuccess()
        default:
            // TODO: Handle Error
            return
        }                
    }
    
    // MARK: - Navigation
    @objc func displayAddCitiesScreen() {
        // Navigate to find repo screen
        guard let routing = AppEnvironment.shared().routing,
            let fromNVC = routing.visibleViewController()?.navigationController else {
                return
        }
        
        let findReposEntry = AddForecastsRoutingEntry()                
        let pushNavStyle = PushNavigationStyle(fromNVC: fromNVC,
                                               routingEntry: findReposEntry)
        _ = routing.route(navigationStyle: pushNavStyle, animated: true)
    }
    
    // MARK: - Search
    override func filterContentForSearchText(_ searchText: String) {
        // Only display repo with a issue that has the title search text
        self.filteredForecasts = self.databaseForecasts.filter({( forecast : Forecast) -> Bool in
            return forecast.name?.lowercased().contains(searchText.lowercased()) ?? false
        })
        
        self.isFiltering = true
        
        // Will reload table view and recreates sections with correct items
        self.handleSuccess()
    }
    
    override func didFinishSearch() {
        self.isFiltering = false
        // Will reload table view and recreates sections with correct items
        self.handleSuccess()
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // Only handles edition when we are not filtering
        if self.isFiltering == false {
            // Handles deletion
            if editingStyle == .delete {
                
                let forecast = self.databaseForecasts[indexPath.row]
                
                // Deletes from array
                self.databaseForecasts.remove(at: indexPath.row)
                
                // Removes cell view model in section
                self.loadSections()
                self.configurePositionOnSections()
                
                // Deletes from table view
                
                if tableView.numberOfRows(inSection: indexPath.section) == 1 {
                    tableView.deleteSections(IndexSet(arrayLiteral: indexPath.section),
                                             with: .automatic)
                } else {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
                                
                // Deletes from database
                if let id = forecast.id {
                    _ = AppEnvironment.shared().database?.deleteById(remoteKey: id, type: Forecast.self)
                }                
            }
        }
                
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if self.isFiltering == false {
            return .delete
        }
        
        return .none
    }
    
    // MARK: - Units Format
    @objc func convertUnitsFormat() {
        self.unitFormatIsImperial = !self.unitFormatIsImperial
        
        // Will reload table view and recreates sections with correct items
        self.handleSuccess()
    }
}
