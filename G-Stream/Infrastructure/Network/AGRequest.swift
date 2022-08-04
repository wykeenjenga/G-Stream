//
//  AGReuest.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/29/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation

public enum APHTTPRequestVerb: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

public enum AGRequestBodyEncoding {
    
    case json
    case stringEncoding
    case formEncoded
    
    func encode(bodyParamaters: [String: Any]) -> Data? {
        switch self {
        case .json:
            return try? JSONSerialization.data(withJSONObject: bodyParamaters)
        case .stringEncoding:
            return bodyParamaters.queryString.data(using: String.Encoding.ascii, allowLossyConversion: true)
        case .formEncoded:
            return bodyParamaters.queryString.data(using: String.Encoding.utf8)
        }
    }
}

public protocol AGRequestable {
    
    var path: String { get }
    var isFullPath: Bool { get }
    var method: APHTTPRequestVerb { get }
    var queryParameters: [String: Any] { get }
    var headerParamaters: [String: String] { get }
    var bodyParamaters: [String: Any] { get }
    var bodyEncoding: AGRequestBodyEncoding { get }
    
    func request(with configuration: AGNetworkConfigurable) throws -> URLRequest
}

extension AGRequestable {
    
    private func url(with configuration: AGNetworkConfigurable) throws -> URL {
        //Preping up the endPoint.
        let baseURL = configuration.baseURL.absoluteString.last != "/" ? configuration.baseURL.absoluteString + "/" : configuration.baseURL.absoluteString
        let endPoint = isFullPath ? path : baseURL.appending(path)
        
        guard var urlComponents = URLComponents(string: endPoint) else { throw RequestGenerationError.components }
        var urlQueryItems = [URLQueryItem]()
        
        queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
        }
        
        configuration.queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        
        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        guard let url = urlComponents.url else { throw RequestGenerationError.components }
        return url
    }
    
    public func request(with configuration: AGNetworkConfigurable) throws -> URLRequest {
        let url = try self.url(with: configuration)
        var urlRequest = URLRequest(url: url)
        var headers: [String: String] = configuration.headers
        headerParamaters.forEach({ headers.updateValue($1, forKey: $0) })
        if !bodyParamaters.isEmpty {
            urlRequest.httpBody = bodyEncoding.encode(bodyParamaters: bodyParamaters)
        }
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        return urlRequest
    }
}

public class AGRequest: AGRequestable {

    public var path: String
    public var isFullPath: Bool = false
    public var method: APHTTPRequestVerb = .get
    public var queryParameters: [String: Any] = [:]
    public var headerParamaters: [String: String] = [:]
    public var bodyParamaters: [String: Any] = [:]
    public var bodyEncoding: AGRequestBodyEncoding = .formEncoded
    
    init(path: String,
         isFullPath: Bool = false,
         method: APHTTPRequestVerb = .get,
         queryParameters: [String: Any] = [:],
         headerParamaters: [String: String] = [:],
         bodyParamaters: [String: Any] = [:],
         bodyEncoding: AGRequestBodyEncoding = .formEncoded) {
        self.path = path
        self.isFullPath = isFullPath
        self.method = method
        self.queryParameters = queryParameters
        self.headerParamaters = headerParamaters
        self.bodyParamaters = bodyParamaters
        self.bodyEncoding = bodyEncoding
    }
}

//Support
enum RequestGenerationError: Error {
    case components
}

fileprivate extension Dictionary {
    var queryString: String {
        return self.map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    }
}
