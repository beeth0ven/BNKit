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

public extension IsInBundle {
    
    static var bundle: Bundle {
        return .main
    }
}

// --- IsInBNKitBundle---

extension Bundle {
    
    static let BNKit = Bundle(identifier: "org.cocoapods.BNKit")!
}

protocol IsInBNKitBundle: IsInBundle {}
extension IsInBNKitBundle {
    
    public static var bundleIdentifier: Bundle? {
        return .BNKit
    }
}
