//
//  ScheduledEventsUseCase.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/30/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation

protocol ScheduledEventsUseCase {
    func execute(completion: @escaping (Result<AGScheduledEvents, Error>) -> Void) -> Cancellable?
}

final class DefaultScheduledEventsUseCase: ScheduledEventsUseCase {
   
    private let eventRepository: EventsRepositoryInterface
    
    init(eventRepository: EventsRepositoryInterface) {
        self.eventRepository = eventRepository
    }
    
    func execute(completion: @escaping (Result<AGScheduledEvents, Error>) -> Void) -> Cancellable? {
        return eventRepository.fetchScheduleEvents(completion: completion)
    }
}
