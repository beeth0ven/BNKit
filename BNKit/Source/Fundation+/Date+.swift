//
//  Date+.swift
//  SwitchGift
//
//  Created by luojie on 2017/3/30.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import Foundation

public func -(lhs: Date, rhs: Date) -> TimeInterval {
    return lhs.timeIntervalSince1970 - rhs.timeIntervalSince1970
}
