//
//  IsView.swift
//  BNKit
//
//  Created by luojie on 2016/11/17.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit

/**
 A easy and safe way to initail controller from the storyboard
 
 # Usage Exampe #
 ```swift
 // 1. Declare some class is in bundle
 open class TipView: UIView, IsInBundle { ... }
 
 // 2. User the class somewhere
 class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TipView.show(state: .spinnerOnly)
    }
 }
 
 // Default bundle is current, You can also provide a defferent bundle in that class.
 extension TipView {
    static var bundle: Bundle {
        return Bundle(identifier: "org.cocoapods.BNKit")!
    }
 }
 ```
 */

extension IsInBundle where Self: UIView {
    
    public static func fromNib() -> Self {
        let nibName = String(describing: self)
        return bundle.loadNibNamed(nibName, owner: self, options: nil)!.first as! Self
    }
}
