//
//  NSObject+objc.swift
//  BNKit
//
//  Created by luojie on 2016/11/30.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation

extension NSObject {
    
    public var objc: Objective {
        get {
            return Objective(base: self)
        }
        set {
            // this enables using Objective to "mutate" base type
        }
    }
}
