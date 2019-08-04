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
    
    override var modelToUpdate: Model {
        return Weather()
    }
    
    override func updateProperties(to model: Model) {
        super.updateProperties(to: model)
        
        guard let weather = model as? Weather else { return }
        weather.headline = self.headline
        weather.descriptionText = self.descriptionText
        weather.iconName = self.iconName
    }
    
    override func configure(model: Model) {
        super.configure(model: model)
        
        guard let weather = model as? Weather else { return }
        self.headline = weather.headline
        self.descriptionText = weather.descriptionText
        self.iconName = weather.iconName
    }
    
}
