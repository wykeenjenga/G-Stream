//
//  EventsRepositoryInterface.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/30/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation
import Mapper

protocol EventsRepositoryInterface {
    @discardableResult func fetchLiveEvents(completion: @escaping (Result<AGLiveEvents, Error>) -> Void) -> Cancellable?
    @discardableResult func fetchScheduleEvents(completion: @escaping (Result<AGScheduledEvents, Error>) -> Void) -> Cancellable?
}
