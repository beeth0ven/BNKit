//
//  NSObject+RxValue.swift
//  BNKit
//
//  Created by luojie on 2016/12/4.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

extension Reactive where Base: NSObject {
    
    public func value<Value>(forKey key: String, as type: Value.Type = Value.self) -> ComputedVariable<Value?> {
        return value(forKey: key, default: nil)
    }
    
    public func value<Value>(forKey key: String, default: Value) -> ComputedVariable<Value> {
        return ComputedVariable(
            getter: {
                self.base.value(forKey: key) as? Value ?? `default`
            },
            setter: {
                self.base.setValue($0, forKey: key)
            }
        )
    }

}

