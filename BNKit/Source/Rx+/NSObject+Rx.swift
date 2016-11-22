//
//  NSObject+Rx.swift
//  PhotoMap
//
//  Created by luojie on 16/8/10.
//
//

import Foundation
import RxSwift
import RxCocoa

public protocol HasDisposeBag {
    /// Default DisposeBag
    var disposeBag: DisposeBag { get }
}

extension NSObject: HasDisposeBag {
    
    public var disposeBag: DisposeBag {
        get {
            switch objc_getValue(key: &AssociatedKeys.disposeBag) {
            case let disposeBag as DisposeBag:
                return disposeBag
            default:
                let disposeBag = DisposeBag()
                objc_set(value: disposeBag, key: &AssociatedKeys.disposeBag)
                return disposeBag
            }
        }
        set {
            objc_set(value: newValue, key: &AssociatedKeys.disposeBag)
        }
    }
}

private enum AssociatedKeys {
    static var disposeBag = "disposeBag"
}


