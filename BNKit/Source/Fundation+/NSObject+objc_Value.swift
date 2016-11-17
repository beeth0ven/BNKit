//
//  NSObject+objc_Value.swift
//  PhotoMap
//
//  Created by luojie on 16/8/10.
//
//

import Foundation

extension NSObject {
    
    public func objc_getValue(key: UnsafeRawPointer) -> AnyObject! {
        
        return objc_getAssociatedObject(self, key) as AnyObject!
    }
    
    public func objc_set(value: AnyObject!, key: UnsafeRawPointer, policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
        
        objc_setAssociatedObject(self, key, value, policy)
    }
}

