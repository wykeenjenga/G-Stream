//
//  APExtension+UITableViewCell.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/30/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension UITableViewCell {
    public static var identifier: String {
        return String(describing: self)
    }
}

extension NSManagedObject {
    public static var identifier: String {
        return String(describing: self)
    }
}
