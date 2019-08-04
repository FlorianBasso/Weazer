//
//  AppEnvironment+Tests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
@testable import Weazer

extension AppEnvironment {
    
    func configureEnvironment(with environment: Environment?) {
        self.api = MockAPI()
        self.routing = MockRouting()
        self.database = MockDatabase()
    }
}
