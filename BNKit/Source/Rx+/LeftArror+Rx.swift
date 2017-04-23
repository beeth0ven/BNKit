//
//  LeftArror+Rx.swift
//  BNKit
//
//  Created by luojie on 2017/4/23.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import RxSwift
import RxCocoa

// MARK: ObservableType --> ObserverType

infix operator <== : DefaultPrecedence

public func <==<Base: NSObject, G: ObservableType, S: ObserverType>(baseObserver: (Base, S), observable: G)
    where S.E == G.E {
        let (base, observer) = baseObserver
        observable
            .bind(to: observer)
            .disposed(by: base.disposeBag)
}

public func <==<Base: NSObject, G: ObservableType, S: ObserverType>(baseObserver: (Base, S), observable: G)
    where S.E == G.E? {
        let (base, observer) = baseObserver
        observable
            .bind(to: observer)
            .disposed(by: base.disposeBag)
}

public func <==<Base: NSObject, G: ObservableType>(variable: Variable<G.E>, baseObservable: (Base, G)) {
    let (base, observable) = baseObservable
    observable
        .bind(to: variable)
        .disposed(by: base.disposeBag)
}

public func <==<Base: NSObject, G: ObservableType>(variable: Variable<G.E?>, baseObservable: (Base, G)) {
    let (base, observable) = baseObservable
    observable
        .bind(to: variable)
        .disposed(by: base.disposeBag)
}

public func <==<Base: NSObject, G: ObservableType>(variable: ComputedVariable<G.E>, baseObservable: (Base, G)) {
    let (base, observable) = baseObservable
    observable
        .bind(to: variable)
        .disposed(by: base.disposeBag)
}

public func <==<Base: NSObject, G: ObservableType>(variable: ComputedVariable<G.E?>, baseObservable: (Base, G)) {
    let (base, observable) = baseObservable
    observable
        .bind(to: variable)
        .disposed(by: base.disposeBag)
}

// MARK: Driver --> ObserverType

public func <==<Base: NSObject, D: SharedSequenceConvertibleType, S: ObserverType>(baseObserver: (Base, S), driver: D)
    where D.SharingStrategy == DriverSharingStrategy, S.E == D.E {
        let (base, observer) = baseObserver
        driver
            .drive(observer)
            .disposed(by: base.disposeBag)
}

public func <==<Base: NSObject, D: SharedSequenceConvertibleType, S: ObserverType>(baseObserver: (Base, S), driver: D)
    where D.SharingStrategy == DriverSharingStrategy, S.E == D.E? {
        let (base, observer) = baseObserver
        driver
            .drive(observer)
            .disposed(by: base.disposeBag)
}

public func <==<Base: NSObject, D: SharedSequenceConvertibleType>(variable: Variable<D.E>, baseDriver: (Base, D))
    where D.SharingStrategy == DriverSharingStrategy {
        let (base, driver) = baseDriver
        driver
            .drive(variable)
            .disposed(by: base.disposeBag)
}

public func <==<Base: NSObject, D: SharedSequenceConvertibleType>(variable: Variable<D.E?>, baseDriver: (Base, D))
    where D.SharingStrategy == DriverSharingStrategy {
        let (base, driver) = baseDriver
        driver
            .drive(variable)
            .disposed(by: base.disposeBag)
}

public func <==<Base: NSObject, D: SharedSequenceConvertibleType>(variable: ComputedVariable<D.E>, baseDriver: (Base, D))
    where D.SharingStrategy == DriverSharingStrategy {
        let (base, driver) = baseDriver
        driver
            .drive(variable)
            .disposed(by: base.disposeBag)
}

public func <==<Base: NSObject, D: SharedSequenceConvertibleType>(variable: ComputedVariable<D.E?>, baseDriver: (Base, D))
    where D.SharingStrategy == DriverSharingStrategy {
        let (base, driver) = baseDriver
        driver
            .drive(variable)
            .disposed(by: base.disposeBag)
}


