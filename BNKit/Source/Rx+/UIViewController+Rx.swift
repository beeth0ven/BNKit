//
//  UIViewController+Rx.swift
//  WorkMap
//
//  Created by luojie on 16/9/30.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    
    public var dismiss: AnyObserver<Void> {
        return UIBindingObserver(UIElement: base, binding: { (vc, _) in
            vc.presentingViewController?.dismiss(animated: true, completion: nil)
        }).asObserver()
    }
    
    public var pop: AnyObserver<Void> {
        return UIBindingObserver(UIElement: base, binding: { (vc, _) in
            _ = vc.navigationController?.popViewController(animated: true)
        }).asObserver()
    }
}
