//
//  NSNumber+CGFloat.swift
//  SwitchGift
//
//  Created by luojie on 2017/3/16.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import Foundation
import CoreGraphics

extension NSNumber {
    
    public var cgfloatValue: CGFloat {
        return CGFloat(doubleValue)
    }
}
