//
//  UIViewController+RefreshTrigger.swift
//  BNKit
//
//  Created by luojie on 2017/3/25.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController, Base: ObjectiveCompatible {
    
    public var refreshTrigger: PublishSubject<Void> {
        
        return base.objc.findOrCreateValue(forKey: &Keys.refreshTrigger, createValue: { PublishSubject<Void>() })
    }
    
    public var _refreshTrigger: Observable<Void> {
        
        return base.objc.findOrCreateValue(forKey: &Keys._refreshTrigger, createValue: {
            Queue.main.execute { self.refreshTrigger.onNext() } // For first refresh trigger
            return refreshTrigger
                .debug("refreshTrigger")
                .flatMapLatest {
                    self.base.view.isOnScreen ? Observable.just() : self.viewDidAppear.take(1)
                }
                .shareReplay(1)
        })
    }
}


private enum Keys {
    static var refreshTrigger = "refreshTrigger"
    static var _refreshTrigger = "_refreshTrigger"
}
