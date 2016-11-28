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

public func <-> <T>(property: ControlProperty<T>, params: (disposeBag: DisposeBag, variable: Variable<T>)) {
    (property <-> params.variable).addDisposableTo(params.disposeBag)
}

public func <-> <T>(textInput: TextInput<T>, params: (disposeBag: DisposeBag, variable: Variable<String>)) {
    (textInput <-> params.variable).addDisposableTo(params.disposeBag)
}
