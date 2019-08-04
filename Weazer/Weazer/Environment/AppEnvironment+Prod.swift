//
//  AppEnvironment+Prod.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import SDWebImage

extension AppEnvironment {
    
    func configureEnvironment(with environment: Environment?) {
        self.api = APIRequester()
        self.routing = Routing()
        self.database = RealmDatabase()
        self.imageManager = SDWebImageManager.shared()
    }
}
