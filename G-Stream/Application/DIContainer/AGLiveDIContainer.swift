//
//  AGLiveDIContainer.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/29/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation

final class AGLiveDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: DataTransfer
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeLiveViewController() -> AGLiveViewController {
        return AGLiveViewController.create()
    }
    
}