//
//  NativeClient.swift
//  NetworkingFramework
//
//  Created by Cristian on 31/08/2018.
//  Copyright © 2018 Cristian Barril. All rights reserved.
//

import Foundation

struct NativeClient: NetworkClient {
    
    typealias ReturnTypeObject = [String:Any]
    
    func get(baseURL: String, uri: String, params: [String: Any]?, completitionHandler: @escaping RequestCompletion<ReturnTypeObject>, errorHandler: @escaping RequestCompletionError) {
        
        let urlString = "\(baseURL)\(uri)"
        
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            let session = URLSession.shared
            
            let task = session.dataTask(with: urlRequest) { (data, response, error) in
                // check for any errors
                guard error == nil else {
                    if let errorCode = error as NSError? {
                        print("Request failed with error: \(errorCode)")
                        errorHandler(self.handleError(code: errorCode.code))
                    }
                    return
                }
                
                // make sure we got data
                guard let responseData = data else {
                    print("Error: did not receive data")
                    errorHandler(ServerError.unknown)
                    return
                }
                
                do {
                    guard let jsonData = try JSONSerialization.jsonObject(with: responseData, options: []) as? ReturnTypeObject else {
                        print("error trying to convert data to JSON")
                        errorHandler(ServerError.unknown)
                        return
                    }
                    
                    completitionHandler(jsonData)
                    
                } catch  {
                    print("error trying to convert data to JSON")
                    errorHandler(ServerError.unknown)
                    return
                }
            }
            
            task.resume()
        }
        else {
            print("Fail to generate URL with: \(urlString)")
            errorHandler(ServerError.unknown)
        }
    }
    
    private func handleError(code: Int?) -> ServerError {
        if let status = code {
            switch status {
            case 401:
                return .Unauthorized
            case 404:
                return .NotFound
            case 500:
                return .Internal
            default:
                return .unknown
            }
        }
        return .unknown
    }
}
