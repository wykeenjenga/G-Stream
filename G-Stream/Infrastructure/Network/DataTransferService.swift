//
//  DataTransferService.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/29/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation

public enum DataTransferError: Error {
    case noResponse
    case parsingJSON
    case networkFailure(NetworkError)
}


final public class DataEndpoint<T: Any>: AGRequest { }

public protocol DataTransfer {
    @discardableResult
    func request<T: AGMappable>(with endpoint: DataEndpoint<T>, completion: @escaping (Result<T, Error>) -> Void) -> Cancellable?
    @discardableResult
    func request<T: AGMappable>(with endpoint: DataEndpoint<T>, respondOnQueue: DispatchQueue, completion: @escaping (Result<T, Error>) -> Void) -> Cancellable?
    @discardableResult
    func request<T: AGMappable>(with endpoint: DataEndpoint<T>, completion: @escaping (Result<[T], Error>) -> Void) -> Cancellable?
    @discardableResult
    func request<T: AGMappable>(with endpoint: DataEndpoint<T>, respondOnQueue: DispatchQueue, completion: @escaping (Result<[T], Error>) -> Void) -> Cancellable?
    @discardableResult
    func request(with endpoint: DataEndpoint<Data>, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable?
    @discardableResult
    func request(with endpoint: DataEndpoint<Data>, respondOnQueue: DispatchQueue, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable?
}

public final class DefaultDataTransferService {
    
    private let networkService: NetworkService
    
    public init(with networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension DefaultDataTransferService: DataTransfer {
    
    public func request<T: AGMappable>(with endpoint: DataEndpoint<T>, completion: @escaping (Result<[T], Error>) -> Void) -> Cancellable? {
        return request(with: endpoint, respondOnQueue: .main, completion: completion)
    }
    
    public func request<T: AGMappable>(with endpoint: DataEndpoint<T>, respondOnQueue: DispatchQueue, completion: @escaping (Result<[T], Error>) -> Void) -> Cancellable? {
        
        let task = self.networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let responseData):
                guard let responseData = responseData else {
                    respondOnQueue.async { completion(Result.failure(DataTransferError.noResponse)) }
                    return
                }
                do {
                    let responseArray = try JSONSerialization.jsonObject(with: responseData,
                                                                         options: .mutableLeaves) as? NSArray
                    if let _responseArray = responseArray, let result = T.from(_responseArray) {
                        respondOnQueue.async { completion(.success(result)) }
                    } else {
                        respondOnQueue.async { completion(Result.failure(DataTransferError.parsingJSON))
                        }
                    }
                } catch let error {
                    print(error)
                    respondOnQueue.async { completion(Result.failure(DataTransferError.parsingJSON)) }
                }
            case .failure(let error):
                respondOnQueue.async { completion(Result.failure(DataTransferError.networkFailure(error))) }
            }
        }
        return task
    }
    
    
    public func request<T>(with endpoint: DataEndpoint<T>, completion: @escaping (Result<T, Error>) -> Void) -> Cancellable? where T: AGMappable {
        return request(with: endpoint, respondOnQueue: .main, completion: completion)
    }
    
    public func request(with endpoint: DataEndpoint<Data>, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable? {
        return request(with: endpoint, respondOnQueue: .main, completion: completion)
    }
    
    public func request<T: AGMappable>(with endpoint: DataEndpoint<T>, respondOnQueue: DispatchQueue, completion: @escaping (Result<T, Error>) -> Void) -> Cancellable? {
        
        let task = self.networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let responseData):
                guard let responseData = responseData else {
                    respondOnQueue.async { completion(Result.failure(DataTransferError.noResponse)) }
                    return
                }
                do {
                    let responseDict = try JSONSerialization.jsonObject(with: responseData,
                                                                        options: .mutableLeaves) as? NSDictionary
                    if let _responseDict = responseDict, let result = T.from(_responseDict) {
                        respondOnQueue.async { completion(.success(result)) }
                    }
//                    else {
//                        let responseArray = try JSONSerialization.jsonObject(with: responseData,
//                                                                            options: .mutableLeaves) as? NSArray
//                        if let _responseArray = responseArray, let result = T.from(_responseArray) {
//                            respondOnQueue.async { completion(.success(result)) }
//                        }
//                    }
                } catch {
                    respondOnQueue.async { completion(Result.failure(DataTransferError.parsingJSON)) }
                }
            case .failure(let error):
                respondOnQueue.async { completion(Result.failure(DataTransferError.networkFailure(error))) }
            }
        }
        
        return task
    }
    
    public func request(with endpoint: DataEndpoint<Data>, respondOnQueue: DispatchQueue, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable? {
        let task = self.networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let responseData):
                guard let responseData = responseData
                    else {
                        respondOnQueue.async { completion(Result.failure(DataTransferError.noResponse)) }
                        return
                }
                respondOnQueue.async { completion(Result.success(responseData)) }
            case .failure(let error):
                respondOnQueue.async { completion(Result.failure(DataTransferError.networkFailure(error))) }
            }
        }
        
        return task
    }
}
