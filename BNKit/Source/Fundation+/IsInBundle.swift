//
//  Bundle+IsInBundle.swift
//  theatre
//
//  Created by luojie on 2016/12/29.
//  Copyright © 2016年 @天意. All rights reserved.
//

import Foundation

public protocol IsInBundle {
    
    static var bundle: Bundle { get }
}

public extension IsInBundle where Self: AnyObject {
    
    static var bundle: Bundle {
        return Bundle(for: Self.self)
    }
}
