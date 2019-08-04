//
//  AddForecastsVM.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class AddForecastsVM: SearchableTVM {
    
    lazy var searchResults = [MKLocalSearchCompletion]()
    lazy var searchCompleter = MKLocalSearchCompleter()
    lazy var locationManager = CLLocationManager()
    
    override var title: String? {
        get {
            return NSLocalizedString("add.forecasts.title", comment: "")
        }
        set {}
    }
    
    override var rightBarButtonItem: UIBarButtonItem? {
        get {
            let image = UIImage(named: "geolocationArrow")
            let addReposItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(requestForecastForUserPosition))
            return addReposItem
        }
        set {}
    }       
    
    var searchText: String?
    
    override var searchBarPlaceholder: String? {
        return NSLocalizedString("add.forecasts.search.placeholder", comment: "")
    }
    
    // MARK: - Sections
    override func sectionToAdd() -> TableSection {
        let section = TableSection()
        
        for result in self.searchResults {
            let cityCVM = CityCellViewModel(cityName: result.title)
            section.items.append(cityCVM)
        }
        
        return section
    }
    
    
    // MARK: - Filter
    override func filterContentForSearchText(_ searchText: String) {
        
        if searchCompleter.delegate == nil {
            searchCompleter.delegate = self
        }
        
        searchCompleter.filterType = .locationsOnly  
        searchCompleter.queryFragment = searchText
    }
    
    // MARK: Geolocation
    @objc func requestForecastForUserPosition() {
        // Request permission to track user position
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
            break
            
        case .denied, .restricted:
            // Redirect to settings so the user can update the permission
            let routingEntry = OpenUrlRoutingEntry(url: UIApplication.openSettingsURLString)
            AppEnvironment.shared().routing?.route(to: routingEntry)
            return
        case .authorizedAlways, .authorizedWhenInUse:
            break
        }
        
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }        
    
}

// MARK: - MKLocalSearchCompleterDelegate
extension AddForecastsVM: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        // Will reload table view and recreates sections with correct items
        self.handleSuccess()
    }
    
    private func completer(completer: MKLocalSearchCompleter, didFailWithError error: NSError) {
        // handle error
    }
}

// MARK: - CLLocationManagerDelegate
extension AddForecastsVM: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            
            self.locationManager.stopUpdatingLocation()
            
            // Get forecast for user position            
            let endpoint = GetCurrentWeatherDataEndpoint(cityName: nil,
                                                         coordinate: (lat: currentLocation.coordinate.latitude, long: currentLocation.coordinate.longitude))
            AppEnvironment.shared().api?.request(with: endpoint, success: { (responseObject) in
                
                if let forecast = responseObject as? Forecast {                    
                    forecast.forUserPosition = true
                    
                    // Save forecast on database
                    AppEnvironment.shared().database?.insertOrUpdate(item: forecast)
                }
                
                // Pop to previous screen
                AppEnvironment.shared().routing?.route(to: PopRoutingEntry())
                
            }, failure: { (operation, error, statusCode) in
                // TODO: Handles error
            })
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // handle error
    }
    
}
