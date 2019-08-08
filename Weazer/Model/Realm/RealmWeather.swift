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
        weather.headline = self.headline
        weather.descriptionText = self.descriptionText
        weather.iconName = self.iconName
    }
    
    override func updatePropertiesToDatabase<T>(from model: T) where T : Model {
        super.updatePropertiesToDatabase(from: model)        
        guard let weather = model as? Weather else { return }
        self.headline = weather.headline
        self.descriptionText = weather.descriptionText
        self.iconName = weather.iconName
    }
    
}
