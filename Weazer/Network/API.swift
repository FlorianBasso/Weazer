//
//  API.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation


public protocol API {
    
    var lastTask: URLSessionTask? { get set }    
    var basePath: String { get }
    func asyncCall(thread: DispatchQoS.QoSClass, call: @escaping () -> ())
    
    // !!!! Every call of request must be done in a asyncCall !!!!
    func request<T: APIEndpoint, U: Any>(with endpoint: T,
                                         resultType: U.Type) -> Swift.Result<U, APIError>
    
}
