//
//  JetError.swift
//  JetRequest
//
//  Created by Yousef on 10/29/20.
//  Copyright © 2020 Yousef. All rights reserved.
//

import Foundation

public struct JetError: Error{
    
    let data: Data?
    let statusCode: Int?
    let error: Error?
    
    internal init(data: Data?, statusCode: Int?, error: Error?) {
        self.data = data
        self.statusCode = statusCode
        self.error = error
    }
}
