//
//  Cache.swift
//  BNBannerScrollView
//
//  Created by luojie on 2016/11/14.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation

public class Cache<KeyType : AnyObjectCastable, ValueType : AnyObjectCastable> {
    
    private let _cache = NSCache<AnyObject, AnyObject>()
    
    public subscript(key: KeyType) -> ValueType? {
        get {
            return _cache.object(forKey: key as AnyObject) as? ValueType
        }
        set {
            switch newValue {
            case let object?:
                _cache.setObject(object as AnyObject, forKey: key as AnyObject)
            default:
                _cache.removeObject(forKey: key as AnyObject)
            }
        }
    }
}


public protocol AnyObjectCastable {}

extension Bool: AnyObjectCastable {}
extension Int: AnyObjectCastable {}
extension String: AnyObjectCastable {}
extension URL: AnyObjectCastable {}
extension Date: AnyObjectCastable {}
extension Data: AnyObjectCastable {}
extension Array: AnyObjectCastable {}
extension Dictionary: AnyObjectCastable {}
extension NSObject: AnyObjectCastable {}



