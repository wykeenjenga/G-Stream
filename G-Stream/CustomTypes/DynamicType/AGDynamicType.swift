//
//  AGDynamicType.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/29/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import Foundation

class Dynamic<T> {
    
    var value: T? {
        didSet {
            bind?(value)
        }
    }
    
    var bind: ((T?)->())?
    
    init(_ _value: T) {
        value = _value
    }
    
    func unbind() {
        bind = nil
    }
}
