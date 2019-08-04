//
//  TimeFormatterTests.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import XCTest
@testable import Weazer

class TimeFormatterTests: TestCase {

    // MARK: - time
    func test_time_shouldNotReturnNil() {
        // Given & When
        let timeString = TimeFormatter.time(from: Date())
        
        // Then
        XCTAssertNotNil(timeString)
    }

}
