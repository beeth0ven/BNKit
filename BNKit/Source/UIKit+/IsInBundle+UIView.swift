//
//  IsView.swift
//  BNKit
//
//  Created by luojie on 2016/11/17.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit

extension IsInBundle where Self: UIView {
    
    public static func fromNib() -> Self {
        let nibName = String(describing: self)
        return bundle.loadNibNamed(nibName, owner: self, options: nil)!.first as! Self
    }
}
