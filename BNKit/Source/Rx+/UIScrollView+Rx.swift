//
//  UIScrollView+Rx.swift
//  SwitchGift
//
//  Created by luojie on 2017/3/30.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UIScrollView {
    
    public var isNearTop: Bool {
        return contentOffset.y < 20
    }
    
    public var isNearBottom: Bool {
        return contentSize.height - (contentOffset.y + bounds.height) < 20
    }
}

extension Reactive where Base: UIScrollView {
    
    public var isNearTop: Observable<Void> {
        return didEndDecelerating
            .map { _ in self.base.isNearTop }
            .filter { $0 }
            .mapToVoid()
            .debug("isNearTop")
    }
    
    public var isNearBottom: Observable<Void> {
        return didEndDecelerating
            .map { _ in self.base.isNearBottom }
            .filter { $0 }
            .mapToVoid()
            .debug("isNearBottom")
    }
}
