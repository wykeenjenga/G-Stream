//
//  Accessors.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/28/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation
import UIKit

struct Accessors {
    
    enum Storyboard: String {
        case main = "Main"
        
        func instantiate(with identifier: String) -> AnyObject {
            let storyboard = UIStoryboard(name: self.rawValue, bundle: nil)
            return storyboard.instantiateViewController(withIdentifier: identifier)
        }
    }
    
    struct AppDelegate {
        static let delegate: AGAppDelegate = UIApplication.shared.delegate as! AGAppDelegate
    }
}
