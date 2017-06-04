//
//  HasBackgroundView+Rx.swift
//  BNKit
//
//  Created by luojie on 2017/5/20.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: HasBackgroundView {
    
    public func loadingView(_ loadingView: UIView) -> UIBindingObserver<Base, Bool> {
        return UIBindingObserver(UIElement: base) { [weak loadingView] base, isLoading in
            base.backgroundView = isLoading ? loadingView : nil
        }
    }
    
    public func emptyView(_ emptyView: UIView) -> UIBindingObserver<Base, Bool> {
        return UIBindingObserver(UIElement: base) { [weak emptyView] base, isEmpty in
            base.backgroundView = isEmpty ? emptyView : nil
        }
    }
}

