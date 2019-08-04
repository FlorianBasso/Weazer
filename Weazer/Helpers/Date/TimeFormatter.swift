//
//  TimeFormatter.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

struct TimeFormatter {
    
    static func time(from date: Date) -> String {
        // Initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        
        // get the date time String from the date object
        return formatter.string(from: date)        
    }
    
}
