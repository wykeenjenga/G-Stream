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
        static func getScheduledEvents() -> URL {
            return URL(string: AGAppConfigurations.apiBaseURL)!.appendingPathComponent("getSchedule")
        }
        
        static func getLiveEvents() -> URL {
            return URL(string: AGAppConfigurations.apiBaseURL)!.appendingPathComponent("getEvents")
        }
    }
    
}
