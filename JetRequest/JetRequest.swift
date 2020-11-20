//
//  JetRequest.swift
//  JetRequest
//
//  Created by Yousef on 9/25/20.
//  Copyright © 2020 Yousef. All rights reserved.
//

import UIKit

public class JetRequest {
    
    private (set) public static var baseURL: String!
    private static var sessionConfiguration: URLSessionConfiguration!
    internal static var urlSession: URLSession!
    
    private init() {}
    
    public static func initSession(baseURL: String, sessionConfiguration: URLSessionConfiguration = .default) {
        self.baseURL = baseURL
        self.sessionConfiguration = sessionConfiguration
        self.urlSession = URLSession(configuration: sessionConfiguration)
    }
    
    public static func request(requestable: JetRequestable, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        _ = Request(requestable: requestable, completion: completion)
    }
    
    public static func request(requestable: JetRequestable, completion: @escaping (Result<([String: Any?]?, Int?), JetError>)-> Void) {
        _ =  Request(requestable: requestable, completion: completion)
    }
    
    public static func request<T: Codable>(requestable: JetRequestable, completion: @escaping (Result<(T?, Int?), JetError>)-> Void) {
        _ =  Request(requestable: requestable, completion: completion)
    }
    
    public static func request(path: String, httpMethod: HTTPMethod)-> Request {
        let fullUrl = baseURL + path
        guard let url = URL(string: fullUrl) else { fatalError("JetRequest.Error: Invalid URL: \(fullUrl)") }
        return Request(urlRequest: URLRequest(url: url), httpMethod: httpMethod)
    }
    
    public static func request(fullURL: String, httpMethod: HTTPMethod)-> Request {
        guard let url = URL(string: fullURL) else { fatalError("JetRequest.Error: Invalid URL: \(fullURL)") }
        return Request(urlRequest: URLRequest(url: url), httpMethod: httpMethod)
    }
    
    public static func request(URL: URL, httpMethod: HTTPMethod)-> Request {
        return Request(urlRequest: URLRequest(url: URL), httpMethod: httpMethod)
    }
    
    public static func downloadFile(url: String, headers: [String: String]?, params: [String: Any]?)-> JetTask {
        let urlObj = RequestBuilder.setupQuery(forUrl: url, params: params)
        let urlRequest = RequestBuilder.setupURLRequest(url: urlObj, httpMethod: HTTPMethod.get, headers: headers)
        return JetTask(urlRequest: urlRequest)
    }
    
    public static func uploadImage(toUrl urlString: String, images: [Image], headers: [String: String]?,
                                   params: [String: String]?)-> JetTask {
        
        guard let url = URL(string: urlString) else {fatalError("JetRequest 51: Invalid URL: \(urlString)")}
        
        // generate boundary string using a unique per-app string
        let boundary = "Boundary-\(NSUUID().uuidString)"
        
        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }
        
        for photo in images {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(photo.parameterName)\"; filename=\"\(photo.imgName)\"\(lineBreak)")
            body.append("Content-Type: \(photo.imgType + lineBreak + lineBreak)")
            body.append(photo.image.jpegData(compressionQuality: 0.5)!)
            body.append(lineBreak)
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        headers?.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
        urlRequest.httpBody = body
        
        return JetTask(urlRequest: urlRequest)
        
    }
    
}
