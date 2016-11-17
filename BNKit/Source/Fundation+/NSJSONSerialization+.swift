//
//  NSJSONSerialization+.swift
//  PhotoMap
//
//  Created by luojie on 16/8/14.
//
//

import Foundation

extension JSONSerialization {
    
    public static func object(from string: String) -> Any? {
        if let
            data = string.data(using: .utf8),
            let object = (try? jsonObject(with: data, options: [])) {
            return object
        }
        return nil
    }
    
    public static func string(from object: Any) -> String? {
        if let
            data = try? data(withJSONObject: object, options: []) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}
