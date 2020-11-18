//
//  Request.swift
//  JetRequest
//
//  Created by Yousef on 9/25/20.
//  Copyright © 2020 Yousef. All rights reserved.
//

import Foundation

public class Request {
    
    private var urlRequest: URLRequest
    private let httpMethod: HTTPMethod
    private var headers: [String: String]?
    private var urlParams: [String: Any]?
    private var bodyParams: [String: Any?]?
    private var parametersEncoding: ParametersEncoding?
    private var dataTask: URLSessionDataTask?
    private var isDirect: Bool = false
    
    internal init(urlRequest: URLRequest, httpMethod: HTTPMethod) {
        self.urlRequest = urlRequest
        self.httpMethod = httpMethod
    }
    
    internal init (requestable: JetRequestable, completion: @escaping (Data?, URLResponse?, Error?)-> Void) {
        self.urlRequest = requestable.urlRequest
        self.httpMethod = requestable.httpMethod
        isDirect = true
        fire(completion: completion)
    }
    
    internal init (requestable: JetRequestable, completion: @escaping (Result<([String: Any?]?, Int?), JetError>)-> Void) {
        self.urlRequest = requestable.urlRequest
        self.httpMethod = requestable.httpMethod
        isDirect = true
        fire(completion: completion)
    }
    
    internal init<T: Codable> (requestable: JetRequestable, completion: @escaping (Result<(T?, Int?), JetError>)-> Void) {
        self.urlRequest = requestable.urlRequest
        self.httpMethod = requestable.httpMethod
        isDirect = true
        fire(completion: completion)
    }
    
    public func set(headers: [String: String])-> Request {self.headers = headers; return self}
    
    public func set(urlParams: [String: Any])-> Request {self.urlParams = urlParams; return self}
    
    public func set(bodyParams: [String: Any?], encoding: ParametersEncoding)-> Request {
        self.bodyParams = bodyParams
        self.parametersEncoding = encoding
        return self
    }
    
    public func fire(completion: @escaping (Data?, URLResponse?, Error?)-> Void) {
        if !isDirect { setupURL() }
        DispatchQueue.global(qos: .userInitiated).async {
            self.dataTask = JetRequest.urlSession.dataTask(with: self.urlRequest) { data, res, error in
                DispatchQueue.main.async { completion(data, res, error) }
            }
            self.dataTask?.resume()
        }
    }
    
    public func fire(completion: @escaping (Result<([String: Any?]?, Int?), JetError>)-> Void) {
        if !isDirect { setupURL() }
        DispatchQueue.global(qos: .userInitiated).async {
            self.dataTask = JetRequest.urlSession.dataTask(with: self.urlRequest) { data, res, error in
                let statusCode = (res as? HTTPURLResponse)?.statusCode
                DispatchQueue.main.async {
                    guard 200 ... 299 ~= (statusCode ?? 0), error == nil else {
                        completion(.failure(JetError(data: data, statusCode: statusCode, error: error)))
                        return
                    }
                    do {
                        let dict = try data?.toDictionsay()
                        completion(.success((dict, statusCode)))
                    } catch(let err) {
                        completion(.failure(JetError(data: data, statusCode: statusCode, error: error)))
                        print("ERROR: JetRequest/RequestClass/line67: decoding error with description: \(err.localizedDescription)")
                    }
                }
            }
            self.dataTask?.resume()
        }
    }
    
    public func fire<T: Decodable>(completion: @escaping(Result<(T?, Int?), JetError>)-> Void) {
        if !isDirect { setupURL() }
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.dataTask = JetRequest.urlSession.dataTask(with: self.urlRequest) { data, res, error in
                let statusCode = (res as? HTTPURLResponse)?.statusCode
                DispatchQueue.main.async {
                    guard 200 ... 299 ~= (statusCode ?? 0), error == nil else {
                        completion(Result.failure(JetError(data: data, statusCode: statusCode, error: error)))
                        return
                    }
                    do {
                        let decodedRes = try data?.decode(to: T.self)
                        completion(Result.success((decodedRes, statusCode)))
                    } catch(let err) {
                        completion(Result.failure(JetError(data: data, statusCode: statusCode, error: err)))
                        print("ERROR: JetRequest/RequestClass/line112: decoding error with description: \(err.localizedDescription)")
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
    
    public func cancel() {
        dataTask?.cancel()
    }
    
}


