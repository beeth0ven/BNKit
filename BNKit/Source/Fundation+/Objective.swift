//
//  Objective.swift
//  BNKit
//
//  Created by luojie on 2016/11/30.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation

public struct Objective<Base> {
    
    public let base: Base
    
    public init(base: Base) {
        self.base = base
    }
}

public protocol ObjectiveCompatible {
    associatedtype CompatibleType
    
    static var objc: Objective<CompatibleType>.Type { get set }
    
    var objc: Objective<CompatibleType> { get set }
}

extension ObjectiveCompatible {
    
    public static var objc: Objective<Self>.Type {
        get {
            return Objective<Self>.self
        }
        set {
            // this enables using Objective to "mutate" base type
        }
    }
    
    public var objc: Objective<Self> {
        get {
            return Objective(base: self)
        }
        set {
            // this enables using Objective to "mutate" base type
        }
    }
}

extension NSObject: ObjectiveCompatible {}
