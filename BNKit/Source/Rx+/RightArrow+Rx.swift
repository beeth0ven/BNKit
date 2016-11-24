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

public func --><OE: ObservableType, OR: ObserverType>(observable: OE, params: (disposeBag: DisposeBag, observer: OR))
    where OR.E == OE.E {
        observable.bindTo(params.observer).addDisposableTo(params.disposeBag)
}

public func --><OE: ObservableType, OR: ObserverType>(observable: OE, params: (disposeBag: DisposeBag, observer: OR))
    where OR.E == OE.E? {
        observable.bindTo(params.observer).addDisposableTo(params.disposeBag)
}

public func --><OE: ObservableType>(observable: OE, params: (disposeBag: DisposeBag, variable: Variable<OE.E>)){
        observable.bindTo(params.variable).addDisposableTo(params.disposeBag)
}

public func --><OE: ObservableType>(observable: OE, params: (disposeBag: DisposeBag, variable: Variable<OE.E?>)) {
        observable.bindTo(params.variable).addDisposableTo(params.disposeBag)
}

public func --><OE: ObservableType>(observable: OE, params: (disposeBag: DisposeBag, binder: (OE) -> Disposable)) {
        observable.bindTo(params.binder).addDisposableTo(params.disposeBag)
}

public func --><OE: ObservableType, R1>(observable: OE, params: (disposeBag: DisposeBag, binder: (OE) -> (R1) -> Disposable, curriedArgument: R1)) {
        observable.bindTo(params.binder, curriedArgument: params.curriedArgument).addDisposableTo(params.disposeBag)
}

// MARK: Driver --> ObserverType

public func --><DE: SharedSequenceConvertibleType, OR: ObserverType>(driver: DE, params: (disposeBag: DisposeBag, observer: OR))
    where DE.SharingStrategy == DriverSharingStrategy, OR.E == DE.E {
        driver.drive(params.observer).addDisposableTo(params.disposeBag)
}

public func --><DE: SharedSequenceConvertibleType, OR: ObserverType>(driver: DE, params: (disposeBag: DisposeBag, observer: OR))
    where DE.SharingStrategy == DriverSharingStrategy, OR.E == DE.E? {
        driver.drive(params.observer).addDisposableTo(params.disposeBag)
}

public func --><DE: SharedSequenceConvertibleType>(driver: DE, params: (disposeBag: DisposeBag, variable: Variable<DE.E>))
    where DE.SharingStrategy == DriverSharingStrategy {
        driver.drive(params.variable).addDisposableTo(params.disposeBag)
}

public func --><DE: SharedSequenceConvertibleType>(driver: DE, params: (disposeBag: DisposeBag, variable: Variable<DE.E?>))
    where DE.SharingStrategy == DriverSharingStrategy {
        driver.drive(params.variable).addDisposableTo(params.disposeBag)
}

public func --><DE: SharedSequenceConvertibleType>(driver: DE, params: (disposeBag: DisposeBag, binder: (Observable<DE.E>) -> Disposable))
    where DE.SharingStrategy == DriverSharingStrategy {
        driver.drive(params.binder).addDisposableTo(params.disposeBag)
}

public func --><DE: SharedSequenceConvertibleType, R1>(driver: DE, params: (disposeBag: DisposeBag, binder: (Observable<DE.E>) -> (R1) -> Disposable, curriedArgument: R1))
    where DE.SharingStrategy == DriverSharingStrategy {
        driver.drive(params.binder, curriedArgument: params.curriedArgument).addDisposableTo(params.disposeBag)
}

// MARK: HasDisposeBag + binding

extension HasDisposeBag where Self: AnyObject {
    
    public func binding<E>(_ binding: @escaping (Self, E) -> Void) -> (disposeBag: DisposeBag, observer: UIBindingObserver<Self, E>) {
        let observer = UIBindingObserver(UIElement: self, binding: binding)
        return (disposeBag, observer)
    }
    
    public func observer<OR: ObserverType>(_ getter: @escaping (Self) -> OR) -> (disposeBag: DisposeBag, observer: OR) {
        return (disposeBag, getter(self))
    }
    
    public func binder<OE: ObservableType>(_ binder: @escaping (OE) -> Disposable) -> (disposeBag: DisposeBag, binder: (OE) -> Disposable) {
        return (disposeBag, binder)
    }
    
    public func binder<OE: ObservableType, R1>(_ binder: @escaping (OE) -> (R1) -> Disposable, curriedArgument: R1) -> (disposeBag: DisposeBag, binder: (OE) -> (R1) -> Disposable, curriedArgument: R1) {
        return (disposeBag, binder, curriedArgument)
    }
    
    public func variable<E>(getter: @escaping (Self) -> Variable<E>) -> (disposeBag: DisposeBag, variable: Variable<E>) {
        return (disposeBag, getter(self))
    }
}

// MARK: HasDisposeBag + binding

extension HasReuseDisposeBag where Self: AnyObject {
    
    public func binding<E>(_ binding: @escaping (Self, E) -> Void) -> (disposeBag: DisposeBag, observer: UIBindingObserver<Self, E>) {
        let observer = UIBindingObserver(UIElement: self, binding: binding)
        return (reuseDisposeBag, observer)
    }
    
    public func observer<OR: ObserverType>(_ getter: @escaping (Self) -> OR) -> (disposeBag: DisposeBag, observer: OR) {
        return (reuseDisposeBag, getter(self))
    }
    
    public func binder<OE: ObservableType>(_ binder: @escaping (OE) -> Disposable) -> (disposeBag: DisposeBag, binder: (OE) -> Disposable) {
        return (reuseDisposeBag, binder)
    }
    
    public func binder<OE: ObservableType, R1>(_ binder: @escaping (OE) -> (R1) -> Disposable, curriedArgument: R1) -> (disposeBag: DisposeBag, binder: (OE) -> (R1) -> Disposable, curriedArgument: R1) {
        return (reuseDisposeBag, binder, curriedArgument)
    }
    
    public func variable<E>(getter: @escaping (Self) -> Variable<E>) -> (disposeBag: DisposeBag, variable: Variable<E>) {
        return (reuseDisposeBag, getter(self))
    }
}

