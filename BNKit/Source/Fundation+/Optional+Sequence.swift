//
//  Optional+Sequence.swift
//  SwitchGift
//
//  Created by luojie on 2017/3/26.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import Foundation

extension Optional where Wrapped: Sequence, Wrapped.Iterator.Element: Equatable {
    
    public func contains(_ member: Wrapped.Iterator.Element) -> Bool {
        switch self {
        case .none:
            return false
        case .some(let sequence):
            return sequence.contains(member)
        }
    }
}


