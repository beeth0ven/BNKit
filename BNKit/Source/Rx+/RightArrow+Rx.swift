//
//  RightArrow+Rx.swift
//  BNKit
//
//  Created by luojie on 2016/11/21.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

infix operator --> : DefaultPrecedence

// MARK: ObservableType --> ObserverType

public func --><OE: ObservableType, B, OR: ObserverType>(observable: OE, params: (base: B, observer: OR))
    where OR.E == OE.E, B: HasDisposeBag, B: AnyObject {
        observable.bindTo(params.observer).addDisposableTo(params.base.disposeBag)
}

public func --><OE: ObservableType, B, OR: ObserverType>(observable: OE, params: (base: B, observer: OR))
    where OR.E == OE.E?, B: HasDisposeBag, B: AnyObject {
        observable.bindTo(params.observer).addDisposableTo(params.base.disposeBag)
}

public func --><OE: ObservableType, B>(observable: OE, params: (base: B, variable: Variable<OE.E>))
    where B: HasDisposeBag, B: AnyObject {
        observable.bindTo(params.variable).addDisposableTo(params.base.disposeBag)
}

public func --><OE: ObservableType, B>(observable: OE, params: (base: B, variable: Variable<OE.E?>))
    where B: HasDisposeBag, B: AnyObject {
        observable.bindTo(params.variable).addDisposableTo(params.base.disposeBag)
}

public func --><OE: ObservableType, B>(observable: OE, params: (base: B, binder: (OE) -> Disposable))
    where B: HasDisposeBag, B: AnyObject {
        observable.bindTo(params.binder).addDisposableTo(params.base.disposeBag)
}

public func --><OE: ObservableType, B, R1>(observable: OE, params: (base: B, binder: (OE) -> (R1) -> Disposable, curriedArgument: R1))
    where B: HasDisposeBag, B: AnyObject {
        observable.bindTo(params.binder, curriedArgument: params.curriedArgument).addDisposableTo(params.base.disposeBag)
}

// MARK: Driver --> ObserverType

public func --><DE: SharedSequenceConvertibleType, B, OR: ObserverType>(driver: DE, params: (base: B, observer: OR))
    where DE.SharingStrategy == DriverSharingStrategy, OR.E == DE.E, B: HasDisposeBag, B: AnyObject {
        driver.drive(params.observer).addDisposableTo(params.base.disposeBag)
}

public func --><DE: SharedSequenceConvertibleType, B, OR: ObserverType>(driver: DE, params: (base: B, observer: OR))
    where DE.SharingStrategy == DriverSharingStrategy, OR.E == DE.E?, B: HasDisposeBag, B: AnyObject {
        driver.drive(params.observer).addDisposableTo(params.base.disposeBag)
}

public func --><DE: SharedSequenceConvertibleType, B>(driver: DE, params: (base: B, variable: Variable<DE.E>))
    where DE.SharingStrategy == DriverSharingStrategy, B: HasDisposeBag, B: AnyObject {
        driver.drive(params.variable).addDisposableTo(params.base.disposeBag)
}

public func --><DE: SharedSequenceConvertibleType, B>(driver: DE, params: (base: B, variable: Variable<DE.E?>))
    where DE.SharingStrategy == DriverSharingStrategy, B: HasDisposeBag, B: AnyObject {
        driver.drive(params.variable).addDisposableTo(params.base.disposeBag)
}

public func --><DE: SharedSequenceConvertibleType, B>(driver: DE, params: (base: B, binder: (Observable<DE.E>) -> Disposable))
    where DE.SharingStrategy == DriverSharingStrategy, B: HasDisposeBag, B: AnyObject {
        driver.drive(params.binder).addDisposableTo(params.base.disposeBag)
}

public func --><DE: SharedSequenceConvertibleType, B, R1>(driver: DE, params: (base: B, binder: (Observable<DE.E>) -> (R1) -> Disposable, curriedArgument: R1))
    where DE.SharingStrategy == DriverSharingStrategy, B: HasDisposeBag, B: AnyObject {
        driver.drive(params.binder, curriedArgument: params.curriedArgument).addDisposableTo(params.base.disposeBag)
}

extension HasDisposeBag where Self: AnyObject {
    
    public func binding<E>(_ binding: @escaping (Self, E) -> Void) -> (base: Self, observer: UIBindingObserver<Self, E>) {
        let observer = UIBindingObserver(UIElement: self, binding: binding)
        return (self, observer)
    }
    
    public func observer<OR: ObserverType>(_ getter: @escaping (Self) -> OR) -> (base: Self, observer: OR) {
        return (self, getter(self))
    }
    
    public func binder<OE: ObservableType>(_ binder: @escaping (OE) -> Disposable) -> (base: Self, binder: (OE) -> Disposable) {
        return (self, binder)
    }
    
    public func binder<OE: ObservableType, R1>(_ binder: @escaping (OE) -> (R1) -> Disposable, curriedArgument: R1) -> (base: Self, binder: (OE) -> (R1) -> Disposable, curriedArgument: R1) {
        return (self, binder, curriedArgument)
    }
    
    public func variable<E>(getter: @escaping (Self) -> Variable<E>) -> (base: Self, variable: Variable<E>) {
        return (self, getter(self))
    }
}

