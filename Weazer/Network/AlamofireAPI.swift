//
//  APIRequester.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireAPI: API {
    
    // MARK: - Properties    
    var lastTask: URLSessionTask?
    var basePath: String {
        return "https://api.openweathermap.org/data/2.5/"
    }
    
    
    func asyncCall(thread: DispatchQoS.QoSClass, call: @escaping () -> ()) {
        DispatchQueue.global(qos: thread).async {
            call()
        }
    }
    
    func request<T, U>(with endpoint: T, resultType: U.Type) -> Swift.Result<U, APIError> where T : APIEndpoint {
        var result: Swift.Result<U, APIError>!
        
        let semaphore = DispatchSemaphore(value: 0)
        
            let currentRequest = SessionManager.default.request(URL(string: "\(self.basePath)\(endpoint.path)")!,
                                                                method: AlamofireAPI.method(apiMethod: endpoint.method),
                                                                parameters: endpoint.entryParameters,
                                                                encoding: URLEncoding.default,
                                                                headers: nil)
            
            self.lastTask = currentRequest.task
            
            currentRequest.responseJSON { (response) in
                switch response.result {
                case .success:
                    if let value = response.result.value,
                        let parsedResult = endpoint.parsing(responseObject: value) as? Swift.Result<U, APIError> {
                        result = parsedResult
                    } else {
                        result = .failure(APIError.parsingError)
                    }
                case .failure(_):
                    result = .failure(APIError.server)
                }
                semaphore.signal()
            }
        
        if semaphore.wait(timeout: .now() + 15) == .timedOut {
            self.lastTask?.cancel()
            result = .failure(APIError.timedOut)
        }
        
        return result
    }
    
    class func method(apiMethod: APIMethod) -> HTTPMethod {
        
        let alamofireMethod: HTTPMethod
        
        switch apiMethod {
        case .get:
            alamofireMethod = .get
        case .post:
            alamofireMethod = .post
        case .put:
            alamofireMethod = .put
        case .delete:
            alamofireMethod = .delete
        }
        
        return alamofireMethod
    }
    
}
