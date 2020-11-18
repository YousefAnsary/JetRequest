//
//  JetTask.swift
//  JetRequest
//
//  Created by Yousef on 10/29/20.
//  Copyright © 2020 Yousef. All rights reserved.
//

import Foundation

public class JetTask {
    
    private let urlRequest: URLRequest
    private var dataTask: URLSessionDataTask?
    private var timer: Timer?
    
    internal init(urlRequest: URLRequest) {
        self.urlRequest = urlRequest
    }
    
    public func fire(completion: @escaping (Data?, URLResponse?, Error?)-> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else {return}
            let task = JetRequest.urlSession?.dataTask(with: self.urlRequest) { data, response, error in
                self.timer?.fire()
                self.timer?.invalidate()
                DispatchQueue.main.async { completion(data, response, error) }
            }
            task?.resume()
        }
    }
    
    public func cancel() {
        dataTask?.cancel()
    }
    
    public func trackProgress(completion: @escaping (Progress)-> Void) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let dataTask = self.dataTask else {return}
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
                completion(dataTask.progress)
            }
        }
    }
    
}
