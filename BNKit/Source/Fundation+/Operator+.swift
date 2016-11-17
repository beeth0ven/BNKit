//
//  Operator+.swift
//  BNKit
//
//  Created by luojie on 2016/11/17.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation

public func >(lhs: Int?, rhs: Int) -> Bool {
    return (lhs ?? 0) > rhs
}
