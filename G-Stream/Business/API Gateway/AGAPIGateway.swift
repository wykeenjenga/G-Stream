//
//  AGAPIGateway.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/30/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation

class AGAPIGateway{
    
    private static let _door = AGAPIGateway.init()
    
    @discardableResult class func door() -> AGAPIGateway {
        return self._door
    }
    
    func getLiveEvents(completion: @escaping(Error?) -> Void) {
        firebase.addFeedComment(feedId: feedId, comment: comment, completion: completion)
    }
}
