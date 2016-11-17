//
//  TimeInterval.swift
//  WorkMap
//
//  Created by luojie on 16/10/13.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    public var minutes: TimeInterval {
        return self * 60
    }
    
    public var hours: TimeInterval {
        return self * 60.0.minutes
    }
    
    public var days: TimeInterval {
        return self * 24.0.hours
    }
}
