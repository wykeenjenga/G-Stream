//
//  AGAPIEndPoints.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/30/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation

struct AGAPIEndPoints {
    struct Requests {
        static func getScheduledEvents() -> (DataEndpoint<AGScheduledEvents>) {
            return DataEndpoint(path: "getSchedule")
        }
        
        static func getLiveEvents() -> (DataEndpoint<AGLiveEvents>) {
            return DataEndpoint(path: "getEvents")
        }
    }
    
}
