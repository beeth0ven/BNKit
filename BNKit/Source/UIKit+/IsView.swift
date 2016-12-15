//
//  IsView.swift
//  BNKit
//
//  Created by luojie on 2016/11/17.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit

public protocol IsView {}
extension UIView: IsView {}
extension IsView where Self: UIView {
    
    public static func fromNib(bundle name: Bundle.Name? = nil) -> Self? {
        let nibName = String(describing: self), bundle = (name?.rawValue).flatMap(Bundle.init(identifier:)) ?? Bundle.main
        return bundle.loadNibNamed(nibName, owner: self, options: nil)!.first as? Self
    }
}
