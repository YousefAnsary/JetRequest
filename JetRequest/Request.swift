//
//  Request.swift
//  JetRequest
//
//  Created by Yousef on 9/25/20.
//  Copyright © 2020 Yousef. All rights reserved.
//

import Foundation

class Request {
    
    private var urlRequest: URLRequest
    private let httpMethod: HTTPMethod
    private var headers: [String: String]?
    private var urlParams: [String: Any]?
    private var bodyParams: [String: Any?]?
    private var parametersEncoding: ParametersEncoding?
    private var dataTask: URLSessionDataTask?
    private var decodingType: Decodable.Type?
    
    internal init(urlRequest: URLRequest, httpMethod: HTTPMethod) {
        self.urlRequest = urlRequest
        self.httpMethod = httpMethod
    }
    
    private init<T: Decodable>(urlRequest: URLRequest, httpMethod: HTTPMethod, decodingType: T.Type) {
        self.urlRequest = urlRequest
        self.httpMethod = httpMethod
    }
    
    public func set(headers: [String: String])-> Request {self.headers = headers; return self}
    
    public func set(urlParams: [String: Any])-> Request {self.urlParams = urlParams; return self}
    
    public func set(bodyParams: [String: Any?], encoding: ParametersEncoding)-> Request {
        self.bodyParams = bodyParams
        self.parametersEncoding = encoding
        return self
    }
    
    public func decode<T: Decodable>(to type: T.Type)-> Request {
        return Request(urlRequest: self.urlRequest, httpMethod: self.httpMethod, decodingType: type)
    }
    
    public func fire(onSuccess: @escaping (Data?, Int?)-> Void, onError: @escaping (Data?, Error?, Int?)-> Void) {
        setupURL()
        DispatchQueue.global(qos: .userInitiated).async {
            self.dataTask = JetRequest.urlSession.dataTask(with: self.urlRequest) { data, res, error in
                let statusCode = (res as? HTTPURLResponse)?.statusCode
                DispatchQueue.main.async {
                    guard 200 ... 299 ~= (statusCode ?? 0), error == nil else {
                        onError(data, error, statusCode); return
                    }
                    onSuccess(data, statusCode)
                }
            }
            self.dataTask?.resume()
        }
    }
    
    public func fire(onSuccess: @escaping ([String: Any?]?, Int?)-> Void, onError: @escaping (Data?, Error?, Int?)-> Void) {
        setupURL()
        DispatchQueue.global(qos: .userInitiated).async {
            self.dataTask = JetRequest.urlSession.dataTask(with: self.urlRequest) { data, res, error in
                let statusCode = (res as? HTTPURLResponse)?.statusCode
                DispatchQueue.main.async {
                    guard 200 ... 299 ~= (statusCode ?? 0), error == nil else {
                        onError(data, error, statusCode); return
                    }
                    do {
                        let dict = try data?.toDictionsay()
                        onSuccess(dict, statusCode)
                    } catch(let err) {
                        onError(data, err, statusCode)
                        print("ERROR: JetRequest/RequestClass/line79: decoding error with description: \(err.localizedDescription)")
                    }
                }
            }
            self.dataTask?.resume()
        }
    }
    
    public func fire<T: Decodable>(onSuccess: @escaping (T?, Int?)-> Void, onError:  @escaping (Data?, Error?, Int?)-> Void) {
        setupURL()
        DispatchQueue.global(qos: .userInitiated).async {
            self.dataTask = JetRequest.urlSession.dataTask(with: self.urlRequest) { data, res, error in
                let statusCode = (res as? HTTPURLResponse)?.statusCode
                DispatchQueue.main.async {
                    guard 200 ... 299 ~= (statusCode ?? 0), error == nil else {
                        onError(data, error, statusCode); return
                    }
                    do {
                        let decodedRes = try data?.decode(to: T.self)
                        onSuccess(decodedRes, statusCode)
                    } catch(let err) {
                        onError(data, err, statusCode)
                        print("ERROR: JetRequest/RequestClass/line101: decoding error with description: \(err.localizedDescription)")
                    }
                }
            }
            self.dataTask?.resume()
        }
    }
    
    private func setupURL() {
        
        let url = RequestBuilder.setupQuery(forUrl: urlRequest.url!.absoluteString, params: urlParams)
        urlRequest = RequestBuilder.setupURLRequest(url: url, httpMethod: httpMethod, headers: headers)
        if httpMethod != .get && bodyParams != nil {
            if parametersEncoding == .formData {
                RequestBuilder.setupFormDataParams(forUrlRequest: &urlRequest, params: bodyParams)
            } else {
                RequestBuilder.setupBodyParams(forUrlRequest: &urlRequest, bodyParams: bodyParams)
            }
        }
        
    }
    
}
