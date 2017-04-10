//
//  Optional+Collection.swift
//  SwitchGift
//
//  Created by luojie on 2017/3/26.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import Foundation

extension Optional where Wrapped: Collection {
    
    public var isEmpty: Bool {
        switch self {
        case .none:
            return true
        case .some(let collection):
            return collection.isEmpty
        }
    }
}
