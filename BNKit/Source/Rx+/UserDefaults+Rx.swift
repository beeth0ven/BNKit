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
    
    public func object<Object>(forKey key: String) -> ComputedVariable<Object?> {
        return object(forKey: key, default: nil)
    }
    
    public func object<Object>(forKey key: String, default: Object) -> ComputedVariable<Object> {
        return ComputedVariable(
            getter: {
                self.base.object(forKey: key) as? Object ?? `default`
            },
            setter: {
                self.base.set($0, forKey: key)
                self.base.synchronize()
            }
        )
    }
}
