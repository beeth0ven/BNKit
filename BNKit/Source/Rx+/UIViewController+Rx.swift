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
    
    public var dismiss: UIBindingObserver<Base, Void> {
        return UIBindingObserver(UIElement: base) { (vc, _) in
            vc.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    public var pop: UIBindingObserver<Base, Void> {
        return UIBindingObserver(UIElement: base) { (vc, _) in
            _ = vc.navigationController?.popViewController(animated: true)
        }
    }
}


extension Reactive where Base: UIViewController {
    
    public var viewDidLoad: Observable<Void> {
        return methodInvoked(#selector(UIViewController.viewDidLoad))
            .mapToVoid()
    }
}
