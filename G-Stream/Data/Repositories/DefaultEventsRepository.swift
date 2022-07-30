//
//  DefaultEventsRepository.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/30/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation
import Mapper

final class DefaultUserRepository {
    
    private let dataTransferService: DataTransfer
    
    init(dataTransferService: DataTransfer) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultUserRepository: EventsRepositoryInterface {
    func fetchLiveEvents(completion: @escaping (Result<AGLiveEvents, Error>) -> Void) -> Cancellable? {
        let endPoint = AGAPIEndPoints.Requests.getLiveEvents()
        return self.dataTransferService.request(with: endPoint) { (response: Result<AGLiveEvents, Error>) in
            switch response {
            case .success(let event):
                completion(.success(event))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchScheduleEvents(completion: @escaping (Result<AGScheduledEvents, Error>) -> Void) -> Cancellable? {
        let endPoint = AGAPIEndPoints.Requests.getScheduledEvents()
        return self.dataTransferService.request(with: endPoint) { (response: Result<AGScheduledEvents, Error>) in
            switch response {
            case .success(let event):
                completion(.success(event))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
