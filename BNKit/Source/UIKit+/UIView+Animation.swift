//
//  UIView+Animation.swift
//  WorkMap
//
//  Created by luojie on 16/10/8.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit

extension UIView {
    
    public func animateUpdate(options: UIViewAnimationOptions = .transitionCrossDissolve, updates: @escaping () -> Void) {
        UIView.transition(
            with: self,
            duration: .animation,
            options: options,
            animations: updates,
            completion: nil
        )
    }
}

extension TimeInterval {
    
    static let animation = 0.3
}
