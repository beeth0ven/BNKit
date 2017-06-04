//
//  HasBackgroundView.swift
//  BNKit
//
//  Created by luojie on 2017/5/20.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import UIKit

public protocol HasBackgroundView: class {
    var backgroundView: UIView? { get set }
}

extension UITableView: HasBackgroundView {}
extension UICollectionView: HasBackgroundView {}

