//
//  IsViewController.swift
//  BNKit
//
//  Created by luojie on 2016/11/17.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit

public protocol IsViewController {}
extension UIViewController: IsViewController {}
extension IsViewController where Self: UIViewController {
    
    public static func from(storyBoard name: UIStoryboard.Name, bundle bundleName: Bundle.Name? = nil) -> Self {
        let identifier = String(describing: self), bundle = (bundleName?.rawValue).flatMap(Bundle.init(identifier:)) ?? Bundle.main
        return UIStoryboard(name: name.rawValue, bundle: bundle).instantiateViewController(withIdentifier: identifier) as! Self
    }
}
