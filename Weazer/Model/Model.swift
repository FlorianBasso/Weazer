//
//  Model.swift
//  Weazer
//
//  Created by Florian Basso on 29/08/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

public protocol Model: Codable, Equatable {
    
    var id: Int? { get set }        
}


