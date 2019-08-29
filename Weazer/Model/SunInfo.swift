//
//  SunInfo.swift
//  Weazer
//
//  Created by Florian Basso on 12/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

class SunInfo: Model {
    
    // Use
    // JSONDecoder().dateDecodingStrategy = .secondsSince1970
    //
    var id: Int?
    var sunrise: Date?
    var sunset: Date?
              
}

extension SunInfo {
    static func ==(lhs: SunInfo, rhs: SunInfo) -> Bool {
        return lhs.id == rhs.id &&
            lhs.sunrise == rhs.sunrise &&
            lhs.sunset == rhs.sunset
    }
}
