//
//  UIRefreshControl+Rx.swift
//  SwitchGift
//
//  Created by luojie on 2017/3/28.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIRefreshControl {
    
    public var refresh: Observable<Void> {
        return controlEvent(.valueChanged)
            .asObservable()
    }
}
