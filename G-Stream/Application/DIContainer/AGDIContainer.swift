//
//  AGDIContainer.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/29/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation

final class APDIContainer {
    
    // MARK: - Network
    lazy var apiDataTransferService: DataTransfer = {
        let config = APNetworkConfiguration(baseURL: URL(string: APAppConfigurations.apiBaseURL)!)
        let apiDataNetwork = DefaultNetworkService(session: URLSession.shared,
                                                   config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
}

extension APDIContainer {
    
    // MARK: DIContainers of scenes
    
    /// Creates User Profile Detail Page DIContainer.
    /// - Parameter user: APUser object whose profile needs to be viewed.
    func makeUserProfileDIContainer(with user: APUser) -> APUserProfileDIContainer {
        let dependencies = APUserProfileDIContainer.Dependencies(apiDataTransferService: apiDataTransferService, user: user)
        return APUserProfileDIContainer(dependencies: dependencies)
    }
    /// Creates create home Page DI Container.
    func makeHomeDIContainer(with user: APUser) -> APHomeDIContainer {
        let dependencies = APHomeDIContainer.Dependencies(apiDataTransferService: apiDataTransferService, user: user)
        return APHomeDIContainer(dependencies: dependencies)
    }
}
