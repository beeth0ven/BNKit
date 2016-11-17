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
