//
//  Dictionary+.swift
//  BNKit
//
//  Created by luojie on 2016/11/17.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation

extension Dictionary {
    
    public init(keyValues: [(Key, Value)]) {
        self.init()
        for keyValue in keyValues {
            self[keyValue.0] = keyValue.1
        }
    }
}

extension Dictionary where Value: OptionalType {
    
    public func filterNil() -> [Key: Value.Wrapped] {
        var result = Dictionary<Key, Value.Wrapped>()
        for (key, optionalType) in self {
            if let wrapped = optionalType.value {
                result[key] = wrapped
            }
        }
        return result
    }
}
