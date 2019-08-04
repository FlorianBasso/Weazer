//
//  Environment.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

protocol Environment {  
    
    var api: API? { get set }
    var routing: Navigator? { get set }
    var database: Database? { get set }
    func configureEnvironment(with environment: Environment?)    
}
