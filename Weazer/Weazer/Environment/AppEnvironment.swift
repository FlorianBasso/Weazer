//
//  AppEnvironment.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

class AppEnvironment: NSObject, Environment {
    
    static let instance = AppEnvironment()
    
    @objc class func shared() -> AppEnvironment {
        return instance
    }
    
    var api: API?
    var routing: Navigator?
    var database: Database?
    var imageManager: ImageManager?
}
