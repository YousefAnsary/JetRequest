//
//  JetRequest.swift
//  JetRequest
//
//  Created by Yousef on 9/25/20.
//  Copyright © 2020 Yousef. All rights reserved.
//

import Foundation

class JetRequest {
    
    private static var baseURL: String!
    private static var sessionConfiguration: URLSessionConfiguration!
    internal static var urlSession: URLSession!
    
    public static func initSession(baseURL: String, sessionConfiguration: URLSessionConfiguration = .default) {
        self.baseURL = baseURL
        self.sessionConfiguration = sessionConfiguration
        self.urlSession = URLSession(configuration: sessionConfiguration)
    }
    
    public static func request(path: String, httpMethod: HTTPMethod)-> Request {
        return Request(urlRequest: URLRequest(url: URL(string: baseURL + path)!), httpMethod: httpMethod)
    }
    
}
