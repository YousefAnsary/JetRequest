//
//  NSMutableData+JetRequest.swift
//  JetRequest
//
//  Created by Yousef on 10/8/20.
//  Copyright © 2020 Yousef. All rights reserved.
//

import Foundation

public extension Data {
    
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
    
}
