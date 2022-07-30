//
//  AGDatabase.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/30/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation
import Alamofire

struct WrappedError: Error {
    var error: Error?
}

class AGDatabase {
    
    func getLiveEvnts(completion: @escaping(([AGLiveEvents], Error?) -> Void)) {
        
        let apiToContact = AGAPIEndPoints.Requests.getLiveEvents()

        AF.request(apiToContact as! URLRequestConvertible).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)

                    // Do what you need to with JSON here!
                    // The rest is all boiler plate code you'll use for API requests


                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
