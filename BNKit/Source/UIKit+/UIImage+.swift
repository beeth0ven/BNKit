//
//  UIImage+.swift
//  BNKit
//
//  Created by luojie on 2017/2/26.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import UIKit


extension UIImage {
    
    public static func onePixelImage(from color: UIColor) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fillEllipse(in: CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
