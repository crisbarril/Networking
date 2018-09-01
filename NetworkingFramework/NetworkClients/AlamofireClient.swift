//
//  AlamofireClient.swift
//  NetworkingFramework
//
//  Created by Cristian on 31/08/2018.
//  Copyright © 2018 Cristian Barril. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct AlamofireClient: NetworkClient {
    
    typealias ReturnTypeObject = JSON
    
    func get(baseURL: String, uri: String, params: [String: Any]?, completitionHandler: @escaping RequestCompletion<ReturnTypeObject>, errorHandler: @escaping RequestCompletionError) {
        
        let url = "\(baseURL)\(uri)"
        
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    if let errorCode = json["errCode"].int {
                        errorHandler(self.handleError(code: errorCode))
                    }
                    else {
                        completitionHandler(json)
                    }
                    
                case .failure(let requestError):
                    print("Request failed with error: \(requestError)")
                    if let errorCode = requestError as? AFError {
                        errorHandler(self.handleError(code: errorCode.responseCode))
                    }
                }
        }
    }
}
