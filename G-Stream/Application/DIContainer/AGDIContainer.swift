//
//  AGDIContainer.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/29/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation

final class AGDIContainer {
    // MARK: - Network
    lazy var apiDataTransferService: DataTransfer = {
        let config = AGNetworkConfiguration(baseURL: URL(string: AGAppConfigurations.apiBaseURL)!)
        let apiDataNetwork = DefaultNetworkService(session: URLSession.shared,
                                                   config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
}

extension AGDIContainer {
    
    // MARK: DIContainers of scenes
    
    /// Creates AGLive DIContainer.
    func makeLiveDIContainer() -> AGLiveDIContainer {
        let dependencies = AGLiveDIContainer.Dependencies(apiDataTransferService: apiDataTransferService)
        return AGLiveDIContainer(dependencies: dependencies)
    }
    /// Creates AGSchedule DI Container.
    func makeScheduleDIContainer() -> AGScheduleDIContainer {
        let dependencies = AGScheduleDIContainer.Dependencies(apiDataTransferService: apiDataTransferService)
        return AGScheduleDIContainer(dependencies: dependencies)
    }
}
