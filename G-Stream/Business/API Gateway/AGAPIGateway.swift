//
//  AGAPIGateway.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/30/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation
import SwiftyJSON

class AGAPIGateway {
    
    private static let _door = AGAPIGateway.init()
    
    
    @discardableResult class func door() -> AGAPIGateway {
        return self._door
    }
    
    func getScheduledEvents(completion: @escaping([AGScheduledEvents], Error?) -> Void) {
        
        var liveEventsArray = [AGScheduledEvents]()

        let url = URL(string: "https://us-central1-dazn-sandbox.cloudfunctions.net/getSchedule")!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil{
                do {
                    let decoder = JSONDecoder()
                    let responseData = try decoder.decode([AGScheduledEvents].self, from: data!)
                    
                    DispatchQueue.main.async {
                        for events in responseData{
                            liveEventsArray.append(events)
                        }
                        completion(liveEventsArray, nil)
                    }
                } catch {
                    print(error)
                }
            }else {
                print(error ?? "Unknown error")
                return
            }
        }
        task.resume()
    }
    
    
    func getLiveEvents(completion: @escaping([AGLiveEvents], Error?) -> Void) {
        
        var liveEventsArray = [AGLiveEvents]()

        let url = URL(string: "https://us-central1-dazn-sandbox.cloudfunctions.net/getEvents")!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil{
                do {
                    let decoder = JSONDecoder()
                    let responseData = try decoder.decode([AGLiveEvents].self, from: data!)
                    
                    DispatchQueue.main.async {
                        for events in responseData{
                            liveEventsArray.append(events)
                        }
                        completion(liveEventsArray, nil)
                    }
                } catch {
                    print(error)
                }
            }else {
                print(error ?? "Unknown error")
                return
            }
        }
        task.resume()
    }
}
