//
//  UIStoryboard+Name.swift
//  WorkMap
//
//  Created by luojie on 16/10/2.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    public struct Name: RawRepresentable {
        
        public let rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

extension Bundle {
    
    public struct Name: RawRepresentable {
        
        public let rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

public protocol ViewControllerType {}
extension UIViewController: ViewControllerType {}
extension ViewControllerType where Self: UIViewController {
    
    public static func from(storyBoard name: UIStoryboard.Name, bundle bundleName: Bundle.Name? = nil) -> Self {
        let identifier = String(describing: self), bundle = (bundleName?.rawValue).flatMap(Bundle.init(identifier:)) ?? Bundle.main
        return UIStoryboard(name: name.rawValue, bundle: bundle).instantiateViewController(withIdentifier: identifier) as! Self
    }
}
