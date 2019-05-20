//
//  HTTPRequest.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 17/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation

struct HTTPRequestParameters {
    let value: [String: Any]
}

public enum HTTPMethod: String {
    case GET
    case HEAD
    case POST
    case PUT
    case DELETE
}

public enum HTTPRequestError: Error {
    case cannotBuildValidURL(baseURL: URL, path: String?)
    case urlContainsQuery(String?)
}

struct HTTPRequest {
    
    let url: URL
    
    let urlComponents: URLComponents
    
    let method: HTTPMethod
    
    let parameters: HTTPRequestParameters?

    let timeout: TimeInterval
    
    init(baseURL: URL, path: String?, method: HTTPMethod, parameters: HTTPRequestParameters? = nil, timeout: TimeInterval = 10) throws {
        guard let url = URL(string: path ?? "/", relativeTo: baseURL) else {
            throw HTTPRequestError.cannotBuildValidURL(baseURL: baseURL, path: path)
        }
        
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw HTTPRequestError.cannotBuildValidURL(baseURL: baseURL, path: path)
        }
        
        self.url = url
        self.urlComponents = urlComponents
        self.method = method
        self.parameters = parameters
        self.timeout = timeout
    }
}
