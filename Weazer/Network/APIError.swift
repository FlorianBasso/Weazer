//
//  APIError.swift
//  Weazer
//
//  Created by Florian Basso on 14/08/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

public enum APIError: Error {
    case wrongUrl
    case timedOut
    case server
    case parsingError
}
