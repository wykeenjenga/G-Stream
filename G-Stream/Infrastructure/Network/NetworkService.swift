//
//  NetworkService.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/29/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//
import Foundation

public protocol Cancellable {
    func cancel()
}

public enum NetworkError: Error {
    case errorStatusCode(statusCode: Int)
    case notConnected
    case cancelled
    case urlGeneration
    case requestError(Error?)
}

public protocol NetworkService {
    
    func request(endpoint: AGRequestable, completion: @escaping (Result<Data?,NetworkError>) -> Void) -> Cancellable?
}

extension NetworkError {
    public var isNotFoundError: Bool { return hasStatusCode(404) }
    
    public func hasStatusCode(_ codeError: Int) -> Bool {
        switch self {
        case let .errorStatusCode(code):
            return code == codeError
        default: return false
        }
    }
}

public protocol NetworkSession {
    func loadData(from request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Cancellable
}

extension URLSessionTask: Cancellable { }

extension URLSession: NetworkSession {
    public func loadData(from request: URLRequest,
                         completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Cancellable {
        let task = dataTask(with: request) { (data, response, error) in
            completionHandler(data, response, error)
        }
        task.resume()
        return task
    }
}

// MARK: - Implementation
final public class DefaultNetworkService {
    
    private let session: NetworkSession
    private let config: AGNetworkConfigurable
    
    public init(session: NetworkSession,
                config: AGNetworkConfigurable) {
        self.session = session
        self.config = config
    }
    
    private func request(request: URLRequest, completion: @escaping (Result<Data?, NetworkError>) -> Void) -> Cancellable {
        
        let sessionDataTask = session.loadData(from: request) { [weak self] (data, response, requestError) in
            var error: NetworkError
            if let requestError = requestError {
                
                if let response = response as? HTTPURLResponse, (400..<600).contains(response.statusCode) {
                    error = .errorStatusCode(statusCode: response.statusCode)
                } else if requestError._code == NSURLErrorNotConnectedToInternet {
                    error = .notConnected
                } else if requestError._code == NSURLErrorCancelled {
                    error = .cancelled
                } else {
                    error = .requestError(requestError)
                }
                completion(.failure(error))
            } else {
                completion(.success(data))
            }
        }
        
        return sessionDataTask
    }
}

extension DefaultNetworkService: NetworkService {
    
    public func request(endpoint: AGRequestable, completion: @escaping (Result<Data?, NetworkError>) -> Void) -> Cancellable? {
        do {
            let urlRequest = try endpoint.request(with: config)
            print("Fucking Url  \(urlRequest)")
            return request(request: urlRequest, completion: completion)
        } catch {
            completion(.failure(NetworkError.urlGeneration))
            return nil
        }
    }
}
