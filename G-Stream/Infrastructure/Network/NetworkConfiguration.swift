//
//  NetworkConfiguration.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/29/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation

public protocol AGNetworkConfigurable {
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var queryParameters: [String: String] { get }
}

public struct AGNetworkConfiguration: AGNetworkConfigurable {
    public var baseURL: URL
    public var headers: [String : String]
    public var queryParameters: [String : String]
    
    public init(baseURL: URL,
                headers: [String: String] = [:],
                queryParameters: [String: String] = [:]) {
        self.baseURL = baseURL
        self.headers = headers
        self.queryParameters = queryParameters
    }
}
