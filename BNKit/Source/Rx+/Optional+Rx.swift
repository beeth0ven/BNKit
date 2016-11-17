//
//  Optional+Rx.swift
//  WorkMap
//
//  Created by luojie on 16/10/17.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension Observable {
    
    public func mapToOptional() -> Observable<Element?> {
        return map(Optional.init)
    }
}

extension Observable where Element: OptionalType {
    
    public func filterNil() -> Observable<Element.Wrapped> {
        return  flatMapLatest { percentResultType -> Observable<Element.Wrapped> in
            switch percentResultType.value {
            case nil:
                return .empty()
            case let wrapped?:
                return .just(wrapped)
            }
        }
    }
}

public protocol OptionalType {
    associatedtype Wrapped
    var value: Wrapped? { get }
}

extension Optional: OptionalType {
    public var value: Wrapped? {
        return self
    }
}

extension SharedSequenceConvertibleType {
    
    public func mapToOptional() -> SharedSequence<Self.SharingStrategy, Self.E?> {
        return map(Optional.init)
    }
}
