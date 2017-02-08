//
//  Test.swift
//  BNKit
//
//  Created by luojie on 2017/2/7.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import Foundation
import BNKit

public func test() -> ComputedVariable<Int> {
    print("Other test()")
    return ComputedVariable(
        getter: { 1 },
        setter: { _ in }
    )
}
