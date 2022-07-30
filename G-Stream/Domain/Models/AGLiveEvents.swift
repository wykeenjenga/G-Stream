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
        case data = "date"
        case imageUrl = "imageUrl"
        case videoUrl = "videoUrl"
    }
    
    var id: String?
    var team: String?
    var league: String?
    var data: String?
    var imageUrl: String?
    var videoUrl: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        team = try container.decodeIfPresent(String.self, forKey: .team)
        league = try container.decodeIfPresent(String.self, forKey: .league)
        data = try container.decodeIfPresent(String.self, forKey: .data)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        videoUrl = try container.decodeIfPresent(String.self, forKey: .videoUrl)
    }
}

extension AGLiveEvents: AGMappable {
    init(map: Mapper) {
        id = map.optionalFrom("id")
        team = map.optionalFrom("team")
        league = map.optionalFrom("league")
        data = map.optionalFrom("data")
        imageUrl = map.optionalFrom("imageUrl")
        videoUrl = map.optionalFrom("videoUrl")
    }
}

