//
//  FileManager+.swift
//  BNKit
//
//  Created by luojie on 2016/11/30.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation

extension FileManager {
    
    var freeByteCount: Int64 {
        let attributes = try! attributesOfFileSystem(forPath: NSHomeDirectory())
        return (attributes[.systemFreeSize] as! NSNumber).int64Value
    }
}
