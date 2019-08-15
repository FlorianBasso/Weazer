//
//  APIEndpoint.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

public protocol APIEndpoint {
    associatedtype Response
    
    var path: String { get }
    var method: APIMethod { get }
    var entryParameters: [String: Any]? { get }
    func parsing(responseObject: Any?) -> Result<Response, APIError>
    func errorMessage(statusCode: Int) -> String
}
