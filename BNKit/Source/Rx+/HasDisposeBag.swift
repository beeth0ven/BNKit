//
//  HasDisposeBag.swift
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

extension NSObject: HasDisposeBag {}

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

private enum AssociatedKeys {
    static var disposeBag = "disposeBag"
}


