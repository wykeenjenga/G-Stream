//
//  AGLiveEvents.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/30/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation

import Mapper

struct AGLiveEvents: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case team = "title"
        case league = "subtitle"
        case date = "date"
        case imageUrl = "imageUrl"
        case videoUrl = "videoUrl"
    }
    
    var id: String?
    var team: String?
    var league: String?
    var date: String?
    var imageUrl: String?
    var videoUrl: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        team = try container.decodeIfPresent(String.self, forKey: .team)
        league = try container.decodeIfPresent(String.self, forKey: .league)
        date = try container.decodeIfPresent(String.self, forKey: .date)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        videoUrl = try container.decodeIfPresent(String.self, forKey: .videoUrl)
    }
}

extension AGLiveEvents: AGMappable {
    init(map: Mapper) {
        id = map.optionalFrom("id")
        team = map.optionalFrom("title")
        league = map.optionalFrom("subtitle")
        date = map.optionalFrom("date")
        imageUrl = map.optionalFrom("imageUrl")
        videoUrl = map.optionalFrom("videoUrl")
    }
}

struct AGLiveEventsModelData: Codable {
    enum CodingKeys: String, CodingKey {
        case liveEvents
    }
    
    var liveEvents: [AGLiveEvents]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        liveEvents = try container.decodeIfPresent([AGLiveEvents].self, forKey: .liveEvents)
    }
    
    init() {
        liveEvents = []
    }
    
}

extension AGLiveEventsModelData: AGMappable {
    init(map: Mapper) {
        liveEvents = map.optionalFrom("liveEvents")
    }
}
