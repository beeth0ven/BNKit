//
//  Array+.swift
//  BNKit
//
//  Created by luojie on 2016/11/17.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation


extension Array {
    
    func element(at index: Index) -> Element? {
        guard startIndex <= index && index < endIndex else {
            return nil
        }
        
        return self[index]
    }
}

extension Array {
    
    mutating func removeFirst(where predicate: (Element) -> Bool) {
        if let index = index(where: predicate) {
            self.remove(at: index)
        }
    }
}
