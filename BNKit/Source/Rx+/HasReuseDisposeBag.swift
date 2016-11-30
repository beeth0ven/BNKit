//
//  HasReuseDisposeBag.swift
//  BNKit
//
//  Created by luojie on 2016/11/24.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public protocol HasReuseDisposeBag: HasDisposeBag {
    var reuseSelector: Selector { get }
    var reuseDisposeBag: DisposeBag { get }
}

extension HasReuseDisposeBag where Self: NSObject, Self: ReactiveCompatible, Self: ObjectiveCompatible  {
    
    public var reuseDisposeBag: DisposeBag {
        switch objc.value(forKey: &AssociatedKeys.reuseDisposeBag) {
        case let disposeBag as DisposeBag:
            return disposeBag
        default:
            let disposeBag = DisposeBag()
            objc.set(value: disposeBag, forKey: &AssociatedKeys.reuseDisposeBag)
            rx.methodInvoked(reuseSelector)
                .subscribe(onNext: { [unowned self] _ in
                    self.objc.set(value: nil, forKey: &AssociatedKeys.reuseDisposeBag)
                })
                .addDisposableTo(disposeBag)
            return disposeBag
        }
    }
}

private enum AssociatedKeys {
    static var reuseDisposeBag = "reuseDisposeBag"
}

