//
//  String+Height.swift
//  SwitchGift
//
//  Created by luojie on 2017/3/16.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import UIKit

extension String {
    
    public func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let rect = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return rect.height
    }
}
