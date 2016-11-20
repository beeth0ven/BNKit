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
    var disposeBag: DisposeBag { get }
}

extension HasDisposeBag where Self: NSObject {
    
    public var disposeBag: DisposeBag {
        
        switch objc_getValue(key: &AssociatedKeys.disposeBag) {
        case let disposeBag as DisposeBag:
            return disposeBag
        default:
            let disposeBag = DisposeBag()
            objc_set(value: disposeBag, key: &AssociatedKeys.disposeBag)
            return disposeBag
        }
    }
}

extension NSObject: HasDisposeBag {}

private enum AssociatedKeys {
    static var disposeBag = "disposeBag"
}


