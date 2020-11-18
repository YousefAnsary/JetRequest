//
//  SyncRequest.swift
//  JetRequest
//
//  Created by Yousef on 10/29/20.
//  Copyright © 2020 Yousef. All rights reserved.
//

import Foundation

public protocol JetRequestable {
    
    var path: String {get}
    var headers: [String: String]? {get}
    var keysContainer: KeyedParams? {get}
    var httpMethod: HTTPMethod {get}
    var parameterEncoding: ParametersEncoding {get}
    
}
