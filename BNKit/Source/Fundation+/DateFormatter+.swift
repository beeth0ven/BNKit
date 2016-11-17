//
//  DateFormatter+.swift
//  BNKit
//
//  Created by luojie on 2016/11/17.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    public static func string(from date: Date, dateStyle: Style = .medium, timeStyle: Style = .medium) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        return dateFormatter.string(from: date)
    }
}
