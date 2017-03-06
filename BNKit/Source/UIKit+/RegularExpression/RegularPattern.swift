//
//  UITextField+RegularPattern.swift
//  WorkMap
//
//  Created by luojie on 2016/11/13.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit

public struct RegularPattern {
    public let input: String
    public let valid: String
}

extension RegularPattern {
    
    public static var all: [String: RegularPattern] = [
        "default": RegularPattern(    // Less than 320 characters
            input: "^.{0,320}",
            valid: "^.{4,320}"
        ),
        "username": RegularPattern(   // At least 4 characters
            input: "[a-zA-Z0-9]{0,320}",
            valid: "[a-zA-Z0-9]{4,}"
        ),
        "password": RegularPattern(   // At least 8 characters with one upper case, one lowwer case and one number
            input: "^.{0,320}",
            valid: "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z0-9$@$!%*?&]{8,}"
        ),
        "email": RegularPattern(
            input: "[A-Za-z0-9@._%+-]{0,320}",
            valid: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        ),
        "chinesePhone": RegularPattern(
            input: "^$|^1\\d{0,10}$",
            valid: "^1\\d{10}$"
        ),
        "code4": RegularPattern(  // 4 digit
            input: "[0-9]{0,4}",
            valid: "[0-9]{4}"
        ),
        "code6": RegularPattern(  // 6 digit
            input: "[0-9]{0,6}",
            valid: "[0-9]{6}"
        ),
        "number": RegularPattern(
            input: "[0-9]{0,}",
            valid: "[0-9]{1,}"
        ),
        "double": RegularPattern(
            input: "[0-9.]{0,320}",
            valid: "^-?(?:0|[1-9]\\d{0,2}(?:,?\\d{3})*)(?:\\.\\d+)?$"
        )
    ]

}

infix operator =~

public func =~(text: String, pattern: String) -> Bool {
    let regularExpression = try! NSRegularExpression(pattern: pattern, options: [])
    let range = regularExpression.rangeOfFirstMatch(in: text, options: [], range: NSRange(location: 0, length: text.characters.count))
    return range.location == 0 && range.length == text.characters.count
}

