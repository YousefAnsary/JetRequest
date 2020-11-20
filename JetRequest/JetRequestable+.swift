//
//  JetRequestable+.swift
//  JetRequest
//
//  Created by Yousef on 11/18/20.
//  Copyright © 2020 Yousef. All rights reserved.
//

import Foundation

extension JetRequestable {
    
    var keysMirror: Mirror? {
        get { return keysContainer != nil ? Mirror(reflecting: keysContainer!) : nil }
    }
    
    var urlRequest: URLRequest {
        get {
            // 1- Check if httpMethod is get then setup query params
            let fullURL = JetRequest.baseURL + path
            let nonNilParams = params?.filter({ $0.value != nil }).mapValues({ $0! })
            let url = httpMethod == .get ? RequestBuilder.setupQuery(forUrl: fullURL, params: nonNilParams) : RequestBuilder.url(fromString: fullURL)
            var request = RequestBuilder.setupURLRequest(url: url, httpMethod: httpMethod, headers: headers)
            if parameterEncoding == .JSON {
                RequestBuilder.setupBodyParams(forUrlRequest: &request, bodyParams: params)
            } else {
                RequestBuilder.setupFormDataParams(forUrlRequest: &request, params: params)
            }
            return request
        }
    }
    
    var params: [String: Any?]? {
        get {
            let mirror = Mirror(reflecting: self)
            let params = mirror.children.filter{ !["keysContainer", "path", "headers"].contains($0.label) }
            let paramsLabels = params.map({ $0.label! })
            let paramsValues = params.map({ $0.value })
            let paramsContainerChilds = self.keysMirror?.children
            let paramsKeys = paramsLabels.map({ label in paramsContainerChilds?.first{ child in child.label == label }?.value as? String ?? label })
            let dict = Dictionary(zip(paramsKeys, paramsValues), uniquingKeysWith: { (first, _) in first })
            if dict.count > 0 { return dict } else { return nil }
        }
    }
    
}

extension JetRequestable {
    
    public func fire(completion: @escaping (Data?, URLResponse?, Error?)-> Void) {
        JetRequest.request(requestable: self, completion: completion)
    }
    
    public func fire(completion: @escaping (Result<([String: Any?]?, Int?), JetError>)-> Void) {
        JetRequest.request(requestable: self, completion: completion)
    }
    
    public func fire<T: Codable>(completion: @escaping (Result<(T?, Int?), JetError>)-> Void) {
        JetRequest.request(requestable: self, completion: completion)
    }
    
}
