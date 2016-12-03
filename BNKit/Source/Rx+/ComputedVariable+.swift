//
//  ComputedVariable+.swift
//  BNKit
//
//  Created by luojie on 2016/11/28.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


extension ComputedVariable {
    
    public func asDriver() -> Driver<E> {
        return self.asObservable()
            .asDriver(onErrorDriveWith: .empty())
    }
}

extension ObservableType {
    
    public func bindTo(_ variable: ComputedVariable<E>) -> Disposable {
        return subscribe { e in
            switch e {
            case let .next(element):
                variable.value = element
            case let .error(error):
                print("Binding error to variable: \(error)")
            case .completed:
                break
            }
        }
    }
    
    public func bindTo(_ variable: ComputedVariable<E?>) -> Disposable {
        return self.map { $0 as E? }.bindTo(variable)
    }
}

private let driverErrorMessage = "`drive*` family of methods can be only called from `MainThread`.\n" +
"This is required to ensure that the last replayed `Driver` element is delivered on `MainThread`.\n"

extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {

    public func drive(_ variable: ComputedVariable<E>) -> Disposable {
        MainScheduler.ensureExecutingOnScheduler(errorMessage: driverErrorMessage)
        return drive(onNext: { e in
            variable.value = e
        })
    }
    
    public func drive(_ variable: ComputedVariable<E?>) -> Disposable {
        MainScheduler.ensureExecutingOnScheduler(errorMessage: driverErrorMessage)
        return drive(onNext: { e in
            variable.value = e
        })
    }
}


public func <-> <Base: UITextInput>(textInput: TextInput<Base>, variable: ComputedVariable<String>) -> Disposable {
    let bindToUIDisposable = variable.asObservable()
        .bindTo(textInput.text)
    let bindToVariable = textInput.text
        .subscribe(onNext: { [weak base = textInput.base] n in
            guard let base = base else {
                return
            }
            
            let nonMarkedTextValue = nonMarkedText(base)

            if let nonMarkedTextValue = nonMarkedTextValue, nonMarkedTextValue != variable.value {
                variable.value = nonMarkedTextValue
            }
            }, onCompleted:  {
                bindToUIDisposable.dispose()
        })
    
    return Disposables.create(bindToUIDisposable, bindToVariable)
}

public func <-> <T>(property: ControlProperty<T>, variable: ComputedVariable<T>) -> Disposable {
    if T.self == String.self {
        #if DEBUG
            fatalError("It is ok to delete this message, but this is here to warn that you are maybe trying to bind to some `rx_text` property directly to variable.\n" +
                "That will usually work ok, but for some languages that use IME, that simplistic method could cause unexpected issues because it will return intermediate results while text is being inputed.\n" +
                "REMEDY: Just use `textField <-> variable` instead of `textField.rx_text <-> variable`.\n" +
                "Find out more here: https://github.com/ReactiveX/RxSwift/issues/649\n"
            )
        #endif
    }
    
    let bindToUIDisposable = variable.asObservable()
        .bindTo(property)
    let bindToVariable = property
        .subscribe(onNext: { n in
            variable.value = n
        }, onCompleted:  {
            bindToUIDisposable.dispose()
        })
    
    return Disposables.create(bindToUIDisposable, bindToVariable)
}

public func <-> <T>(property: ControlProperty<T>, params: (disposeBag: DisposeBag, variable: ComputedVariable<T>)) {
    (property <-> params.variable).addDisposableTo(params.disposeBag)
}

public func <-> <T>(textInput: TextInput<T>, params: (disposeBag: DisposeBag, variable: ComputedVariable<String>)) {
    (textInput <-> params.variable).addDisposableTo(params.disposeBag)
}
