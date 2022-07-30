//
//  Theme.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/28/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation
import UIKit

enum Theme: Int {
    
    case light

    private static var selectedThemeKey: String {
        return "selectedThemeKey"
    }
    
    static func currentTheme() -> Theme {
        if let storedTheme = (UserDefaults.standard.value(forKey: selectedThemeKey) as AnyObject).integerValue {
            return Theme(rawValue: storedTheme)!
        } else {
            return .light
        }
    }
    
    static func applyTheme(theme: Theme) {
        // First persist the selected theme using NSUserDefaults.
        UserDefaults.standard.setValue(theme.rawValue, forKey: selectedThemeKey)
        UserDefaults.standard.synchronize()
        
        // You get your current (selected) theme and apply the main color to the tintColor property of your application’s window.
        let sharedApplication = UIApplication.shared
        sharedApplication.delegate?.window??.tintColor = theme.pinkColor
        
        UINavigationBar.appearance().barTintColor = theme.backgroundColor
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : theme.darkTextColor]
        
    }

    var backgroundColor: UIColor {
        switch self {
        case .light:
            return .white
        }
    }
    
    var pinkColor: UIColor {
        switch self {
        case .light:
            return UIColor(red: 205/255, green: 17/255, blue: 112/255, alpha: 1.0)
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .light:
            return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        }
    }
    
    var darkTextColor: UIColor {
        switch self {
        case .light:
            return UIColor(red: 97/255, green: 97/255, blue: 97/255, alpha: 1.0)
        }
    }
    
    var lightTextColor: UIColor {
        switch self {
        case .light:
            return UIColor(red: 126/255, green: 125/255, blue: 127/255, alpha: 1.0)
        }
    }
    
    var selectedTabTextColor: UIColor {
        switch self {
        case .light:
            return UIColor(red: 120, green: 189/255, blue: 194/255, alpha: 1.0)
        }
    }
    
    var redColor: UIColor {
        switch self {
        case .light:
            return UIColor(red: 208/255, green: 2/255, blue: 27/255, alpha: 1.0)
        }
    }
    
    var appGradientColors: [UIColor] {
        switch self {
        case .light:
            return [UIColor(red: 103/255, green: 65/255, blue: 106/255, alpha: 1.0), UIColor(red: 69/255, green: 62/255, blue: 101/255, alpha: 1.0),UIColor(red: 22/255, green: 58/255, blue: 95/255, alpha: 1.0)]
        }
    }
    
    var alertDefaultButtonColor: UIColor {
        switch self {
        case .light:
            return UIColor(red: 191.0/255.0, green: 51.0/255.0, blue: 98.0/255.0, alpha: 1.0)
        }
    }
    
    var unselectedStateColor: UIColor {
        switch self {
        case .light:
            return UIColor(red: 216.0/255.0, green: 216.0/255.0, blue: 216.0/255.0, alpha: 0.68)
        }
    }
    
    var clearColor: UIColor {
        return .clear
    }
}
