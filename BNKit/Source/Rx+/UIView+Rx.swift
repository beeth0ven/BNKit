//
//  UIView+Rx.swift
//  WorkMap
//
//  Created by luojie on 16/10/25.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIView {
    
    public var isShowed: UIBindingObserver<Base, Bool> {
        return UIBindingObserver(UIElement: self.base) { view, isShowed in
            view.isShowed = isShowed
        }
    }
}
