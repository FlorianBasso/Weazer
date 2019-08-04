//
//  APIEndpoint.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

protocol APIEndpoint {
    
    var path: String { get }
    var method: APIMethod { get }
    var entryParameters: [AnyHashable: Any]? { get }
    
    func parsing(responseObject: Any?) -> Any?
    func errorMessage(statusCode: Int) -> String
}
