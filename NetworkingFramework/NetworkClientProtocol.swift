//
//  NetworkClient
//  NetworkingFramework
//
//  Created by Cristian on 31/08/2018.
//  Copyright © 2018 Cristian Barril. All rights reserved.
//

import Foundation

typealias RequestCompletion<T> = (_ responseObject:T) -> ()
typealias RequestCompletionError = (_ error: ServerError) -> ()

// VER MEDIUM: https://medium.com/@jamesrochabrun/using-closures-generics-pop-and-protocols-with-associated-types-to-create-reusable-apis-for-your-a9d3468ce6b1

enum ServerError: Int {
    case Unauthorized = 401
    case NotFound = 404
    case Internal = 500
    case unknown = -999
}

protocol NetworkClient {
    associatedtype ReturnTypeObject
    
    func get(baseURL: String, uri: String, params: [String: Any]?, completitionHandler: @escaping RequestCompletion<ReturnTypeObject>, errorHandler: @escaping RequestCompletionError)
}

extension NetworkClient {
    
    func handleError(code: Int?) -> ServerError {
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
