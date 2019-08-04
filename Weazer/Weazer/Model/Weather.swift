//
//  Weather.swift
//  Weazer
//
//  Created by Florian Basso on 12/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

class Weather: Model {
    
    var headline: String?
    var descriptionText: String?
    var iconName: String?
    
    struct Constants {
        static let main = "main"
        static let description = "description"
        static let icon = "icon"
    }
    
    // MARK: - Parsing
    
    override open func parse(data: [AnyHashable : Any]) {
        super.parse(data: data)
        
        // Headline
        if let headline = data[Constants.main] as? String {
            self.headline = headline
        }
        
        // Description
        if let description = data[Constants.description] as? String {
            self.descriptionText = description
        }
        
        // Icon
        if let iconName = data[Constants.icon] as? String {
            self.iconName = iconName
        }
        
    }
}
