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

extension HasDisposeBag where Self: ObjectiveCompatible, Self: NSObject {

    public var disposeBag: DisposeBag {
        switch objc.value(forKey: &AssociatedKeys.disposeBag) {
        case let disposeBag as DisposeBag:
            return disposeBag
        default:
            let disposeBag = DisposeBag()
            objc.set(value: disposeBag, forKey: &AssociatedKeys.disposeBag)
            return disposeBag
        }
    }
}

private enum AssociatedKeys {
    static var disposeBag = "disposeBag"
}


