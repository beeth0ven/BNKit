//
//  UIApplication+.swift
//  BNKit
//
//  Created by luojie on 2016/11/17.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit

extension UIApplication {
    func openSettings() {
        openURL(URL(string: UIApplicationOpenSettingsURLString)!)
    }
}
