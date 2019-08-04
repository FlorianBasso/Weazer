//
//  TestCase.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class TestCase: XCTestCase {

    var routing: MockRouting!
    var api: MockAPI!
    var database: MockDatabase!
    
    override func setUp() {
        // Refresh AppEnvironment before each test
        AppEnvironment.shared().configureEnvironment(with: nil)
        self.routing = (AppEnvironment.shared().routing as! MockRouting)
        self.api = (AppEnvironment.shared().api as! MockAPI)
        self.database = (AppEnvironment.shared().database as! MockDatabase)
    }
    
}
