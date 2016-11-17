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
    
    public var show: UIBindingObserver<Base, Bool> {
        return UIBindingObserver(UIElement: self.base) { view, show in
            view.isHidden = !show
        }
    }
}
