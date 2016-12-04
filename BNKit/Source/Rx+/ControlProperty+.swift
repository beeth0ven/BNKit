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
    
    public func map<R>(onObservale: @escaping (E) -> R, onObserver: @escaping (R) -> E) -> ControlProperty<R> {
        let getter = map(onObservale)
        let setter = mapObserver(onObserver)
        return ControlProperty<R>(values: getter, valueSink: setter)
    }
    
    public func map<R: Equatable>(onObservale: @escaping (E)-> R, onObserver: @escaping (R) -> E) -> ControlProperty<R> {
        let getter = map(onObservale).distinctUntilChanged()
        let setter = mapObserver(onObserver)
        return ControlProperty<R>(values: getter, valueSink: setter)
    }
}

extension ControlProperty {
    
    public func map<R>(_ transformer: Transformer<E, R>) -> ControlProperty<R> {
        return map(onObservale: transformer.mapSource, onObserver: transformer.mapDestination)
    }
    
    public func map<R: Equatable>(_ transformer: Transformer<E, R>) -> ControlProperty<R> {
        return map(onObservale: transformer.mapSource, onObserver: transformer.mapDestination)
    }
}
