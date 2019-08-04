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
    
    var lastEndpoint: APIEndpoint?
    var basePath: String = ""
    var lastTask: URLSessionDataTask?
    var apiKey: String?
    var locale: String = ""
    var apiVersion: String = ""
    
    func request(with endpoint: APIEndpoint, callback: ((Int) -> Void)?) {
        
        self.lastEndpoint = endpoint
        
        if self.callbackSucceed {
            callback?(200)
        } else {
            callback?(500)
        }
    }
    
    open func request(with endpoint: APIEndpoint, success: ((Bool) -> Void)?) {
        
        self.lastEndpoint = endpoint
        
        if self.callbackSucceed {
            success?(true)
        } else {
            success?(false)
        }
    }
    
    open func request(with endpoint: APIEndpoint, success: ((Any?) -> Void)?, failure: ((URLSessionTask?, Error?, Int) -> Void)?) {
        
        self.lastEndpoint = endpoint
        
        if self.callbackSucceed {
            success?(self.mockResponseObject)
        } else {
            failure?(nil, self.errorForFailure, 500)
        }
    }
    
    open func handleSuccess(withResponseObject responseObject: Any?, endpoint: APIEndpoint, success: ((Any?) -> Void)?) {
        success?(self.mockResponseObject)
    }
    
    open func handleFailure(withOperation operation: URLSessionTask?, error: Error?, failure: ((URLSessionTask?, Error?, Int) -> Void)?) {
        failure?(nil, self.errorForFailure, 500)
    }
    
    open var callbackSucceed = false
    open var mockResponseObject: Any?
    
    private lazy var errorForFailure: Error = {
        let response = HTTPURLResponse(url: URL(string: "url")!, statusCode: 500, httpVersion: nil, headerFields: nil)
        var userInfo = [String: Any]()
        userInfo["com.alamofire.serialization.response.error.response"] = response
        return NSError(domain: "domain", code: 500, userInfo: userInfo)
    }()
    
    // MARK: - Get
    
    open func loggedGET(_ URLString: String, parameters: Any?, success successBlock: ((URLSessionTask?, Any?) -> Void)?, failure: ((URLSessionTask?, Error?) -> Void)?) -> URLSessionDataTask? {
        return nil
    }
    
    // MARK: - Put
    
    open func loggedPUT(_ URLString: String, parameters: Any?, success successBlock: ((URLSessionTask?, Any?) -> Void)?, failure: ((URLSessionTask?, Error?) -> Void)?) -> URLSessionDataTask? {
        return nil
    }
    
    // MARK: - Post
    
    open var loggedPOSTCalled = false
    open func loggedPOST(_ URLString: String, parameters: Any?, success successBlock: ((URLSessionTask?, Any?) -> Void)?, failure: ((URLSessionTask?, Error?) -> Void)?) -> URLSessionDataTask? {
        return nil
    }
    
    // MARK: - Delete
    
    open var loggedDELETECalled = false
    open func loggedDELETE(_ URLString: String, parameters: Any?, success successBlock: ((URLSessionTask?, Any?) -> Void)?, failure: ((URLSessionTask?, Error?) -> Void)?) -> URLSessionDataTask? {
        return nil
    }
    
}
