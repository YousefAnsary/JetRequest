//
//  RequestBuilder.swift
//  JetRequest
//
//  Created by Yousef on 9/25/20.
//  Copyright © 2020 Yousef. All rights reserved.
//

import Foundation

internal class RequestBuilder {
    
    internal static func setupQuery(forUrl url: String, params: [String: Any]?)-> URL {
        var urlComponents = URLComponents(string: url)
        urlComponents?.query = queryString(fromDict: params)
        precondition(urlComponents?.url != nil, "Invalid URL: \(url)")
        return urlComponents!.url!
    }
    
    private static func queryString(fromDict dict: [String: Any]?)-> String? {
        return dict?.map { key, val in "\(key)=\(val)" }.joined(separator: "&")
    }
    
    internal static func setupURLRequest(url: URL, httpMethod: HTTPMethod, headers: [String: String]?)-> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        headers?.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
        return urlRequest
    }
    
    internal static func setupBodyParams(forUrlRequest request: inout URLRequest, bodyParams: [String: Any?]?) {
        guard let bodyParams = bodyParams else { return }
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: bodyParams, options: [])
        } catch {
            print("invalid body params with err: \(error.localizedDescription)")
        }
        
    }
    
    internal static func setupFormDataParams(forUrlRequest request: inout URLRequest, params: [String: Any?]?) {
        guard let params = params else {return}
        let data = params.map{"\($0.key)=\($0.value ?? "null")"}.joined(separator: "&")
        request.httpBody = data.data(using: .utf8)
    }
    
}
