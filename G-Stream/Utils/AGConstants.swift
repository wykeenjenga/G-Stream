//
//  AGConstants.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/28/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation
import UIKit


struct ConstantStrings{
    static let gSorry = "Sorry!"
    static let gExperiencingTechnicalIssue = "We are experience some technical problem. Please try again"
    static let gOk = "OK"
}

struct OnboardingImages{
    static let schedule = UIImage(named: "schedule")
    static let fans = UIImage(named: "fans")
    static let stream = UIImage(named: "stream")
}

struct OnboardingTitles{
    static let schedule = "Find Scheduled Events"
    static let fans = "Let's Celebrate Together"
    static let stream = "Stream All Over the World"
}

struct OnboardingSubTitles{
    static let schedule = "Find scheduled football events on G-Stream, Don't miss any action by your team."
    static let fans = "The first 90 mins are the most important. Join other fans to stream live and celebrate your team."
    static let stream = "Enjoy High Defination(HD) live motion pictures with G-Stream, avoid buffering, and ejoy the match."
}


struct Header{
    static let headers: [String: String] = [
              "Cookie": "signature=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI1ZWM0ZGJmMDA1ZmJjMzBkZTBiYmYzYjUiLCJlbWFpbCI6InRlc3RAdGVzdC5jb20iLCJpYXQiOjE1OTI2MzkyNTIsImV4cCI6MTYwMDQxNTI1Mn0.cQMOtMAiylR1mc_fQwH3RXCmBPnkupk33rGZSbmLfmY",
              "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI1ZWM0ZGJmMDA1ZmJjMzBkZTBiYmYzYjUiLCJlbWFpbCI6InRlc3RAdGVzdC5jb20iLCJpYXQiOjE1OTI2MzkyNTIsImV4cCI6MTYwMDQxNTI1Mn0.cQMOtMAiylR1mc_fQwH3RXCmBPnkupk33rGZSbmLfmY"]
}

struct StreamingVideoURL{
    static var videoUrl = ""
}

struct ConvertDate{
    static func convert(dt: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let date = dateFormatter.date(from: dt)!

        print(date)
        return date
    }
}
