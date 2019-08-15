//
//  MockAPI.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
@testable import Weazer

class MockAPI: API {
    
    var lastTask: URLSessionTask?
    var lastEndpoint: Any?
    var basePath: String = ""
    var mockResult: Result<Any, APIError>?
        
    func asyncCall(thread: DispatchQoS.QoSClass, call: @escaping () -> ()) {
        call()
    }
    
    func request<T, U>(with endpoint: T, resultType: U.Type) -> Result<U, APIError> where T : APIEndpoint {
        self.lastEndpoint = endpoint
        
        guard let mockResult = self.mockResult?.map({$0 as! U}) else {
            return Result.failure(.parsingError)
        }
        
        return mockResult
    }
    
}
