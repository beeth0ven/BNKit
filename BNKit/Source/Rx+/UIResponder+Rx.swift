//
//  UIResponder+Rx.swift
//  WorkMap
//
//  Created by luojie on 16/10/25.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIResponder {
    
    public var isFirstResponder: UIBindingObserver<Base, Bool> {
        return UIBindingObserver(UIElement: self.base) { responder, active in
            _ = active ? responder.becomeFirstResponder() : responder.resignFirstResponder()
        }
    }
}
