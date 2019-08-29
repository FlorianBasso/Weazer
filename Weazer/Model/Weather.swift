//
//  Weather.swift
//  Weazer
//
//  Created by Florian Basso on 12/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

class Weather: Model {
    
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
    
}

extension Weather {
    static func ==(lhs: Weather, rhs: Weather) -> Bool {
        return lhs.id == rhs.id &&
            lhs.main == rhs.main &&
            lhs.description == rhs.description &&
            lhs.icon == rhs.icon
    }
}
