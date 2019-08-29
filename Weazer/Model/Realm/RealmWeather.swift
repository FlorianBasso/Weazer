//
//  RealmUser.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import RealmSwift

class RealmWeather: RealmModel {
    
    // MARK: - Properties
    dynamic var headline: String?
    dynamic var descriptionText: String?
    dynamic var iconName: String?
    
    // MARK: - YMMRealmObject        
    
    override func updatePropertiesFromDatabase<T>(to model: T) where T : Model {
        super.updatePropertiesFromDatabase(to: model)
        guard let weather = model as? Weather else { return }
        weather.id = self.id
        weather.main = self.headline
        weather.description = self.descriptionText
        weather.icon = self.iconName
    }
    
    override func updatePropertiesToDatabase<T>(from model: T) where T : Model {
        super.updatePropertiesToDatabase(from: model)        
        guard let weather = model as? Weather else { return }
        self.id = weather.id ?? 0
        self.headline = weather.main
        self.descriptionText = weather.description
        self.iconName = weather.icon
    }
    
}
