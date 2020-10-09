//
//  JetRequest.swift
//  JetRequest
//
//  Created by Yousef on 9/25/20.
//  Copyright © 2020 Yousef. All rights reserved.
//

import UIKit

public class JetRequest {
    
    private static var baseURL: String!
    private static var sessionConfiguration: URLSessionConfiguration!
    internal static var urlSession: URLSession!
    internal static let imageCache = NSCache<AnyObject, UIImage>()
    
    private init() {}
    
    public static func initSession(baseURL: String, sessionConfiguration: URLSessionConfiguration = .default) {
        self.baseURL = baseURL
        self.sessionConfiguration = sessionConfiguration
        self.urlSession = URLSession(configuration: sessionConfiguration)
    }
    
    public static func request(path: String, httpMethod: HTTPMethod)-> Request {
        return Request(urlRequest: URLRequest(url: URL(string: baseURL + path)!), httpMethod: httpMethod)
    }
    
    public static func downloadImage(url: String, completion: @escaping (UIImage?)-> Void) {
        guard let urlObject = URL(string: url) else {return}
        DispatchQueue.global(qos: .userInitiated).async {
            urlSession.dataTask(with: urlObject) { data, res, err in
                guard let data = data, err == nil else {print("Err Fetching data from \(url)"); return}
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }// End DispatchQueue main closure
            }.resume() //End data task closure
        }// End DispatchQueue userInitiated closure
    }
    
    public static func downloadFile(url: String,
                                    completion: @escaping (_ progress: Progress?, _ fileTempUrl: URL?, URLResponse?, Error?)-> Void) {
        
        guard let urlObject = URL(string: url) else {return}
        var timer: Timer?
        DispatchQueue.global(qos: .userInitiated).async {
            let task = urlSession.downloadTask(with: urlObject) { tempUrl, res, error in
                timer?.invalidate()
                let progress = Progress()
                progress.totalUnitCount = 1
                progress.completedUnitCount = 1
                DispatchQueue.main.async { completion(progress, tempUrl, res, error) }
            }//End data task closure
            
            task.resume()
            
            DispatchQueue.main.async{
                timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
                    completion(task.progress, nil, nil, nil)
                }
            }
            
        }// End DispatchQueue userInitiated closure
        
    }
    
    public static func uploadImage(toUrl urlString: String, images: [Image], headers: [String: String]?, params: [String: String]?,
                                   completion: @escaping (_ progress: Progress?, Data?, URLResponse?, Error?)-> Void) {
        
        let url = URL(string: urlString)
        
        // generate boundary string using a unique per-app string
        let boundary = "Boundary-\(NSUUID().uuidString)"
        
        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: url!)
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
        
        DispatchQueue.global(qos: .userInitiated).async {
            var timer: Timer?
            let task = urlSession?.dataTask(with: urlRequest) { data, response, error in
                timer?.invalidate()
                let progress = Progress()
                progress.totalUnitCount = 1
                progress.completedUnitCount = 1
                DispatchQueue.main.async { completion(progress, data, response, error) }
            }
            
            task?.resume()
            
            DispatchQueue.main.async{
                timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
                    completion(task?.progress, nil, nil, nil)
                }
            }
            
        }
        
    }
    
}
