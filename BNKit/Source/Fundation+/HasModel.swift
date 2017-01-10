//
//  HasModel.swift
//  BNKit
//
//  Created by luojie on 2017/1/10.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import Foundation

public protocol HasModel {
    associatedtype Model
    var model: Model! { get set }
}
