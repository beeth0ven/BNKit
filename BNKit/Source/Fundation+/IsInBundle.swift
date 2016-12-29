//
//  Bundle+IsInBundle.swift
//  theatre
//
//  Created by luojie on 2016/12/29.
//  Copyright © 2016年 @天意. All rights reserved.
//

import Foundation

public protocol IsInBundle {
    static var bundleIdentifier: String? { get }
}

public extension IsInBundle {
    static var bundleIdentifier: String? {
        return nil
    }
    
    static var bundle: Bundle {
        return bundleIdentifier.flatMap(Bundle.init(identifier:)) ?? .main
    }
}

// --- IsInBNKitBundle---
protocol IsInBNKitBundle: IsInBundle {}
extension IsInBNKitBundle {
    public static var bundleIdentifier: String? {
        return "org.cocoapods.BNKit"
    }
}
