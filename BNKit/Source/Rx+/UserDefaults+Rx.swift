//
//  UserDefaults+Rx.swift
//  BNKit
//
//  Created by luojie on 2016/12/3.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UserDefaults {
    
    public func value<Value>(forKey key: String, default: Value) -> ComputedVariable<Value> {
        return ComputedVariable<Value>(
            getter: {
                self.base.value(forKey: key) as? Value ?? `default`
            },
            setter: {
                self.base.setValue($0, forKey: key)
                self.base.synchronize()
            }
        )
    }
}
