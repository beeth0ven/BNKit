//
//  RxExtension.swift
//  BNKit
//
//  Created by luojie on 2017/4/23.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import RxSwift


public struct RxExtension<Base> {
    public let rx: Reactive<Base>
    
    public var base: Base {
        return rx.base
    }
}

extension Reactive {
    
    public var re: RxExtension<Base> {
        get { return RxExtension(rx: self) }
        set {
            // this enables using Reactive to "mutate" base type
        }
    }
    
    public static var ex: RxExtension<Base>.Type {
        get { return RxExtension<Base>.self }
        set {
            // this enables using Reactive to "mutate" base type
        }
    }
}
