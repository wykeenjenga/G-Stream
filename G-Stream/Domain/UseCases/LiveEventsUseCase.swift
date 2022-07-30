//
//  LiveEventsUseCase.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/30/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation

protocol LiveEventsUseCase {
    @discardableResult func execute(with userId: String, completion: @escaping (Result<AGLiveEvents, Error>) -> Void) -> Cancellable?
}

final class DefaultLiveEventsUseCase: LiveEventsUseCase {
   
    private let eventRepository: EventsRepositoryInterface
    
    init(eventRepository: EventsRepositoryInterface) {
        self.eventRepository = eventRepository
    }
    
    @discardableResult func execute(with userId: String, completion: @escaping (Result<AGLiveEvents, Error>) -> Void) -> Cancellable? {
        return eventRepository.fetchLiveEvents(completion: completion)
    }
}
