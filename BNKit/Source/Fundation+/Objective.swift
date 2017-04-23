//
//  Objective.swift
//  BNKit
//
//  Created by luojie on 2016/11/30.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation

public struct Objective {
    
    public let base: NSObject
    
    public init(base: NSObject) {
        self.base = base
    }
}

extension Objective {
    
    public func findOrCreateValue<T>(forKey key: UnsafeRawPointer, createValue: () -> T) -> T {
        
        switch value(forKey: key) {
        case let result as T:
            return result
        default:
            let result = createValue()
            set(value: result, forKey: key)
            return result
        }
    }
    
    public func value(forKey key: UnsafeRawPointer) -> Any! {
        
        return objc_getAssociatedObject(base, key)
    }
    
    public func set(value: Any!, forKey key: UnsafeRawPointer, policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
        
        objc_setAssociatedObject(base, key, value, policy)
    }
}
