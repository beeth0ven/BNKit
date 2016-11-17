//
//  InfoPlist.swift
//  PhotoMap
//
//  Created by luojie on 16/8/9.
//
//

import Foundation

public enum InfoPlist {
    
    static private let info = Bundle.main.infoDictionary! as NSDictionary
    
    public static func value(forKeyPath keyPath: String) -> Any? {
        return info.value(forKeyPath: keyPath)
    }
}
