//
//  UIBar+SeparatorHiden.swift
//  BNKit
//
//  Created by luojie on 2017/2/26.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    @IBInspectable
    public var separatorHiden: Bool {
        get { return shadowImage != nil }
        set {
            let image: UIImage? = newValue ? UIImage.onePixelImage(from: .clear) : nil
            shadowImage = image
            setBackgroundImage(image, for: .default)
        }
    }
}

extension UITabBar {
    
    @IBInspectable
    public var separatorHiden: Bool {
        get { return shadowImage != nil }
        set {
            let image: UIImage? = newValue ? UIImage.onePixelImage(from: .clear) : nil
            shadowImage = image
            backgroundImage = image
        }
    }
}
