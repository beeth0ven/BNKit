//
//  ControlProperty+.swift
//  BNKit
//
//  Created by luojie on 2016/11/29.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ControlProperty {
    
    public func map<R>(mapGetter: @escaping (E)-> R, mapSetter: @escaping (R) -> E) -> ControlProperty<R> {
        let getter = map(mapGetter)
        let setter = mapObserver(mapSetter)
        return ControlProperty<R>(values: getter, valueSink: setter)
    }
    
    public func map<R: Equatable>(mapGetter: @escaping (E)-> R, mapSetter: @escaping (R) -> E) -> ControlProperty<R> {
        let getter = map(mapGetter).distinctUntilChanged()
        let setter = mapObserver(mapSetter)
        return ControlProperty<R>(values: getter, valueSink: setter)
    }
}
