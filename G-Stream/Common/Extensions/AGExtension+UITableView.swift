//
//  APExtension+UITableView.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/30/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    open func register(_ cell: UITableViewCell.Type...) {
        cell.forEach {
            let nib = UINib(nibName: $0.identifier, bundle: nil)
            register(nib, forCellReuseIdentifier: $0.identifier)
        }
    }
    
    /// dequeue as subscript. Example: let cell = tableView[CellType.self, indexPath]
    open subscript<CellClass: UITableViewCell>(cellType: CellClass.Type, indexPath: IndexPath) -> CellClass {
        return dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as! CellClass
    }
    
    /// dequeue as subscript. Example: let cell = tableView[CellType.self]
    open subscript<CellClass: UITableViewCell>(cellType: CellClass.Type) -> CellClass {
        return dequeueReusableCell(withIdentifier: cellType.identifier) as! CellClass
    }
}

extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }
        
        return lastIndexPath == indexPath
    }
}
