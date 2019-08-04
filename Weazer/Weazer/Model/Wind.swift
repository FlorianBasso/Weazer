//
//  Wind.swift
//  Weazer
//
//  Created by Florian Basso on 12/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

class Wind: Model {
    
    var speed: Double?
    var degree: Int?
    
    struct Constants {
        static let speed = "speed"
        static let degree = "deg"        
    }
    
    // MARK: - Parsing
    
    override open func parse(data: [AnyHashable : Any]) {
        super.parse(data: data)
        
        // Speed
        if let speed = data[Constants.speed] as? Double {
            self.speed = speed
        }
        
        // Degree
        if let degree = data[Constants.degree] as? Int {
            self.degree = degree
        }
        
    }
    
    override func remoteKey(inRepresentation representation: [AnyHashable: Any]) -> Int {
        guard let allWind = AppEnvironment.shared().database?.getAll(type: Wind.self) else {
            return 0
        }
        
        return allWind.count + 1
    }
}
