//
//  API.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

protocol API {
    
    func loggedGET(_ URLString: String,
                   parameters: Any?,
                   success successBlock: ((_ operation: URLSessionTask?, _ responseObject: Any?) -> Void)?,
                   failure: ((_ operation: URLSessionTask?, _ error: Error?) -> Void)?) -> URLSessionDataTask?
    
    func loggedPOST(_ URLString: String,
                    parameters: Any?,
                    success successBlock: ((_ operation: URLSessionTask?, _ responseObject: Any?) -> Void)?,
                    failure: ((_ operation: URLSessionTask?, _ error: Error?) -> Void)?) -> URLSessionDataTask?
    
    func loggedPUT(_ URLString: String,
                   parameters: Any?,
                   success successBlock: ((_ operation: URLSessionTask?, _ responseObject: Any?) -> Void)?,
                   failure: ((_ operation: URLSessionTask?, _ error: Error?) -> Void)?) -> URLSessionDataTask?
    
    func loggedDELETE(_ URLString: String,
                      parameters: Any?,
                      success successBlock: ((_ operation: URLSessionTask?, _ responseObject: Any?) -> Void)?,
                      failure: ((_ operation: URLSessionTask?, _ error: Error?) -> Void)?) -> URLSessionDataTask?
    
    
    var lastEndpoint: APIEndpoint? { get set }
    var lastTask: URLSessionDataTask? { get set }    
    var basePath: String { get }
    
    func request(with endpoint: APIEndpoint, callback: ((_ statusCode: Int) -> Void)?)
    func request(with endpoint: APIEndpoint, success: ((_ success: Bool) -> Void)?)
    func request(with endpoint: APIEndpoint, success: ((_ responseObject: Any?) -> Void)?,
                 failure: ((_ operation: URLSessionTask?, _ error: Error?, _ statusCode: Int) -> Void)?)
    
    
    func handleSuccess(withResponseObject responseObject: Any?,
                       endpoint: APIEndpoint, success: ((_ responseObject: Any?) -> Void)?)
    
    func handleFailure(withOperation operation: URLSessionTask?,
                       error: Error?,
                       failure: ((_ operation: URLSessionTask?, _ error: Error?, _ statusCode: Int) -> Void)?)
    
}

