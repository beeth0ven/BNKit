//
//  UIView+.swift
//  BNKit
//
//  Created by luojie on 2016/11/17.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit

extension UIView {
    
    public var isShowed: Bool {
        get { return !isHidden }
        set { isHidden = !newValue }
    }
    
    public var isOnScreen: Bool {
        return window != nil
    }
}
