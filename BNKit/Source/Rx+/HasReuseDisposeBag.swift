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
        
        return objc.findOrCreateValue(forKey: &Keys.reuseDisposeBag, createValue: {
            let disposeBag = DisposeBag()
            objc.set(value: disposeBag, forKey: &Keys.reuseDisposeBag)
            rx.methodInvoked(reuseSelector)
                .subscribe(onNext: { [unowned self] _ in
                    self.objc.set(value: nil, forKey: &Keys.reuseDisposeBag)
                })
                .disposed(by: disposeBag)
            return disposeBag
        })
    }
}

private enum Keys {
    static var reuseDisposeBag = "reuseDisposeBag"
}

