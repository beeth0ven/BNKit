//
//  NSObject+objc.swift
//  BNKit
//
//  Created by luojie on 2016/11/30.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation

extension Objective where Base: NSObject {
    
    public func value(forKey key: UnsafeRawPointer) -> Any! {
        
        return objc_getAssociatedObject(base, key)
    }
    
    public func set(value: Any!, forKey key: UnsafeRawPointer, policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
        
        objc_setAssociatedObject(base, key, value, policy)
    }
}
