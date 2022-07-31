//
//  AGScheduledEvents.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/30/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation
import Mapper

struct AGScheduledEvents: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case team = "title"
        case league = "subtitle"
        case date = "date"
        case imageUrl = "imageUrl"
    }
    
    var id: String?
    var team: String?
    var league: String?
    var date: String?
    var imageUrl: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        team = try container.decodeIfPresent(String.self, forKey: .team)
        league = try container.decodeIfPresent(String.self, forKey: .league)
        date = try container.decodeIfPresent(String.self, forKey: .date)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
    }
}

extension AGScheduledEvents: AGMappable {
    init(map: Mapper) {
        id = map.optionalFrom("id")
        team = map.optionalFrom("team")
        league = map.optionalFrom("league")
        date = map.optionalFrom("data")
        imageUrl = map.optionalFrom("imageUrl")
    }
}


struct AGScheduledEventsModelData: Codable {
    enum CodingKeys: String, CodingKey {
        case scheduledEvents
    }
    
    var scheduledEvents: [AGScheduledEvents]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        scheduledEvents = try container.decodeIfPresent([AGScheduledEvents].self, forKey: .scheduledEvents)
    }
    
    init() {
        scheduledEvents = []
    }
    
}

extension AGScheduledEventsModelData: AGMappable {
    init(map: Mapper) {
        scheduledEvents = map.optionalFrom("liveEvents")
    }
}
