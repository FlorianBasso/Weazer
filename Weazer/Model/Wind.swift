//
//  Wind.swift
//  Weazer
//
//  Created by Florian Basso on 12/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

class Wind: Model {
    var id: Int?
    var speed: Double?
    var deg: Int?
    
    private enum CodingKeys: String, CodingKey {
        case speed
        case deg
    }
    
}

extension Wind {
    static func ==(lhs: Wind, rhs: Wind) -> Bool {
        return lhs.id == rhs.id &&
            lhs.speed == rhs.speed &&
            lhs.deg == rhs.deg
    }
}
