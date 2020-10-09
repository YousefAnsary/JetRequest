//
//  Date+Decodable.swift
//  JetRequest
//
//  Created by Yousef on 9/25/20.
//  Copyright © 2020 Yousef. All rights reserved.
//

import Foundation

public extension Data {
    
    public func decode<T: Decodable>(to: T.Type) throws -> T? {
        return try JSONDecoder().decode(T.self, from: self)
    }
    
    public func toDictionsay() throws -> [String: Any?]? {
        return try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any?]
    }
    
}
