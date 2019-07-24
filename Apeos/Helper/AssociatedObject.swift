//
//  AssociatedObject.swift
//  Apeos
//
//  Created by Rodrigo Alexis Garcia Baroni on 12/06/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation

public struct AssociatedObject {
    
    static func get<T: Any>(base: Any, key: UnsafePointer<UInt8>, initializer: () -> T) -> T {
        if let v = objc_getAssociatedObject(base, key) as? T {
            return v
        }
        
        let v = initializer()
        objc_setAssociatedObject(base, key, v, .OBJC_ASSOCIATION_RETAIN)
        return v
    }
    
    static func get<T: Any>(base: Any, key: UnsafePointer<UInt8>) -> T? {
        return objc_getAssociatedObject(base, key) as? T
    }
    
    static func set<T: Any>(base: Any, key: UnsafePointer<UInt8>, value: T) {
        objc_setAssociatedObject(base, key, value, .OBJC_ASSOCIATION_RETAIN)
    }
}
