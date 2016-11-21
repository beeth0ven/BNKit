//
//  Operators+.swift
//  BNKit
//
//  Created by luojie on 2016/11/21.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public func <-> <B, T>(property: ControlProperty<T>, params: (base: B, variable: Variable<T>))
    where B: HasDisposeBag, B: AnyObject {
    (property <-> params.variable).addDisposableTo(params.base.disposeBag)
}

public func <-> <B, T>(textInput: TextInput<T>, params: (base: B, variable: Variable<String>))
    where B: HasDisposeBag, B: AnyObject {
        (textInput <-> params.variable).addDisposableTo(params.base.disposeBag)
}
