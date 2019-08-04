//
//  APIRequester.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import AFNetworking

class APIRequester: AFHTTPSessionManager, API {
    
    // MARK: - Properties
    var lastEndpoint: APIEndpoint?
    var lastTask: URLSessionDataTask?
    var basePath: String {
        return "https://api.openweathermap.org/data/2.5/"
    }
    
    struct Constants {
        static let applicationJSON = "application/json"
    }
    
    // MARK: - Init
    
    init() {
        super.init(baseURL: nil, sessionConfiguration: nil)
        self.requestSerializer = AFJSONRequestSerializer()
        
        self.responseSerializer = AFJSONResponseSerializer(readingOptions: .allowFragments)
        var acceptableContentTypes = Set<String>()
        acceptableContentTypes.insert(Constants.applicationJSON)
        self.responseSerializer.acceptableContentTypes = acceptableContentTypes
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Network Methods
    func loggedGET(_ URLString: String, parameters: Any?, success successBlock: ((_ operation: URLSessionTask?, _ responseObject: Any?) -> Void)?, failure: ((_ operation: URLSessionTask?, _ error: Error?) -> Void)?) -> URLSessionDataTask? {
        return get(URLString, parameters: parameters, progress: nil, success: successBlock, failure: failure)
    }
    
    func loggedPOST(_ URLString: String,
                    parameters: Any?,
                    success successBlock: ((_ operation: URLSessionTask?, _ responseObject: Any?) -> Void)?,
                    failure: ((_ operation: URLSessionTask?, _ error: Error?) -> Void)?) -> URLSessionDataTask? {
        let bodyConstructingBlock: ((_ formData: AFMultipartFormData) -> Void)? = {(_ formData: AFMultipartFormData) -> Void in
            if let params = parameters as? [String: Any] {
                for o: String in params.keys {
                    if let image = params[o] as? UIImage,
                        let imageData = image.jpegData(compressionQuality: 0.75) {
                        formData.appendPart(withFileData: imageData, name: o, fileName: o, mimeType: "image/jpeg")
                    }
                }
            }
        }
        
        return post(URLString, parameters: parameters, constructingBodyWith: bodyConstructingBlock, progress: nil, success: successBlock, failure: failure)
    }
    
    func loggedPUT(_ URLString: String, parameters: Any?, success successBlock: ((_ operation: URLSessionTask?, _ responseObject: Any?) -> Void)?, failure: ((_ operation: URLSessionTask?, _ error: Error?) -> Void)?) -> URLSessionDataTask? {
        return put(URLString, parameters: parameters, success: successBlock, failure: failure)
    }
    
    func loggedDELETE(_ URLString: String, parameters: Any?, success successBlock: ((_ operation: URLSessionTask?, _ responseObject: Any?) -> Void)?, failure: ((_ operation: URLSessionTask?, _ error: Error?) -> Void)?) -> URLSessionDataTask? {
        return delete(URLString, parameters: parameters, success: successBlock, failure: failure)
    }
    
    
    func handleFailure(withOperation operation: URLSessionTask?, error: Error?, failure: ((_ operation: URLSessionTask?, _ error: Error?, _ statusCode: Int) -> Void)?) {
        if let response = (error as NSError?)?.userInfo["com.alamofire.serialization.response.error.response"]  as? HTTPURLResponse {
            failure?(operation, error, response.statusCode)
        }
        else if let response = operation?.response as? HTTPURLResponse {
            failure?(operation, error, response.statusCode)
        } else {
            failure?(operation, error, 0)
        }
    }
}


extension APIRequester {
    // MARK: - Request
    
    func request(with endpoint: APIEndpoint,
                 callback: ((_ statusCode: Int) -> Void)?) {
        self.request(with: endpoint, success: {(_ responseObject: Any) -> Void in
            callback?(200)
        }, failure: {(_ operation: URLSessionTask?, _ error: Error?, _ statusCode: Int) -> Void in
            callback?(statusCode)
        })
    }
    
    func request(with endpoint: APIEndpoint,
                 success: ((_ success: Bool) -> Void)?) {
        self.request(with: endpoint, success: {(_ responseObject: Any) -> Void in
            success?(true)
        }, failure: {(_ operation: URLSessionTask?, _ error: Error?, _ statusCode: Int) -> Void in
            success?(false)
        })
    }
    
    func request(with endpoint: APIEndpoint,
                 success: ((_ responseObject: Any?) -> Void)?,
                 failure: ((_ operation: URLSessionTask?, _ error: Error?, _ statusCode: Int) -> Void)?) {
        
        let path = "\(self.basePath)/\(endpoint.path)"
        let params = endpoint.entryParameters ?? [AnyHashable: Any]()
        
        self.lastEndpoint = endpoint
        
        
        switch endpoint.method {
        case .get:
            self.lastTask = self.loggedGET(path, parameters: params, success: { [weak self] (_ operation: URLSessionTask?, _ responseObject: Any) -> Void in
                self?.handleSuccess(withResponseObject: responseObject, endpoint: endpoint, success: success)
                }, failure: { [weak self] (_ operation: URLSessionTask?, _ error: Error?) -> Void in
                    self?.handleFailure(withOperation: operation, error: error, failure: failure)
            })
            
        case .post:
            self.lastTask = self.loggedPOST(path, parameters: params, success: { [weak self] (_ operation: URLSessionTask?, _ responseObject: Any) -> Void in
                self?.handleSuccess(withResponseObject: responseObject, endpoint: endpoint, success: success)
                }, failure: { [weak self] (_ operation: URLSessionTask?, _ error: Error?) -> Void in
                    self?.handleFailure(withOperation: operation, error: error, failure: failure)
            })
            
        case .put:
            self.lastTask = self.loggedPUT(path, parameters: params, success: { [weak self] (_ operation: URLSessionTask?, _ responseObject: Any) -> Void in
                self?.handleSuccess(withResponseObject: responseObject, endpoint: endpoint, success: success)
                }, failure: { [weak self] (_ operation: URLSessionTask?, _ error: Error?) -> Void in
                    self?.handleFailure(withOperation: operation, error: error, failure: failure)
            })
            
        case .delete:
            self.lastTask = self.loggedDELETE(path, parameters: params, success: { [weak self] (_ operation: URLSessionTask?, _ responseObject: Any) -> Void in
                self?.handleSuccess(withResponseObject: responseObject, endpoint: endpoint, success: success)
                }, failure: { [weak self] (_ operation: URLSessionTask?, _ error: Error?) -> Void in
                    self?.handleFailure(withOperation: operation, error: error, failure: failure)
            })
        }
        
    }
    
    // MARK: - Success
    func handleSuccess(withResponseObject responseObject: Any?,
                       endpoint: APIEndpoint,
                       success: ((_ responseObject: Any?) -> Void)?) {
        success?(endpoint.parsing(responseObject: responseObject))
    }
}

