//
//  Bundle+Name.swift
//  BNKit
//
//  Created by luojie on 2016/11/17.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation

extension Bundle {
    
    public struct Name: RawRepresentable {
        
        public let rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

extension Bundle.Name {
    
    public static let BNKit = Bundle.Name(rawValue: "org.cocoapods.BNKit")
}
