//
//  AGAPIGateway.swift
//  G-Stream
//
//  Created by Wykee Njenga on 8/03/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation
import SwiftyJSON
import Mapper


class AGAPIGateway {

    private static let _door = AGAPIGateway.init()
    
    @discardableResult class func door() -> AGAPIGateway {
        return self._door
    }
    
    func getScheduledEvents(completion: @escaping([AGScheduledEvents], Error?) -> Void) {
        
        var liveEventsArray = [AGScheduledEvents]()

        let endPoint = AGAPIEndPoints.Requests.getScheduledEvents()

        let task = URLSession.shared.dataTask(with: endPoint) { data, response, error in
            if error == nil{
                do {
                    let decoder = JSONDecoder()
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
                    decoder.dateDecodingStrategy = .formatted(formatter)
                    
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
                print(error ?? "fucking Error occured")
                return
            }
        }
        task.resume()
    }
    
    
    func getLiveEvents(completion: @escaping([AGLiveEvents], Error?) -> Void) {
        
        var liveEventsArray = [AGLiveEvents]()
    
        let endPoint = AGAPIEndPoints.Requests.getLiveEvents()

        let task = URLSession.shared.dataTask(with: endPoint) { data, response, error in
            if error == nil{
                do {
                    let decoder = JSONDecoder()
                    //MARK: - sort events by date using date formatter
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
                    decoder.dateDecodingStrategy = .formatted(formatter)

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
                print(error ?? "fucking Error occured")
                return
            }
        }
        task.resume()
    }
}
