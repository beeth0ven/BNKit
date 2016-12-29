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
        switch objc.value(forKey: &Keys.reuseDisposeBag) {
        case let disposeBag as DisposeBag:
            return disposeBag
        default:
            let disposeBag = DisposeBag()
            objc.set(value: disposeBag, forKey: &Keys.reuseDisposeBag)
            rx.methodInvoked(reuseSelector)
                .subscribe(onNext: { [unowned self] _ in
                    self.objc.set(value: nil, forKey: &Keys.reuseDisposeBag)
                })
                .addDisposableTo(disposeBag)
            return disposeBag
        }
    }
}

private enum Keys {
    static var reuseDisposeBag = "reuseDisposeBag"
}

