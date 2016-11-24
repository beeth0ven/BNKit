//
//  UIView+HasReuseDisposeBag.swift
//  BNKit
//
//  Created by luojie on 2016/11/24.
//  Copyright © 2016年 LuoJie. All rights reserved.
//


import RxSwift
import RxCocoa


extension UITableViewCell: HasReuseDisposeBag {
    
    public var reuseSelector: Selector {
        return #selector(UITableViewCell.prepareForReuse)
    }
}

extension UICollectionReusableView: HasReuseDisposeBag {
    
    public var reuseSelector: Selector {
        return #selector(UICollectionReusableView.prepareForReuse)
    }
}
