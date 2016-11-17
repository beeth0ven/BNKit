//
//  UICollectionViewCell+Rx.swift
//  PhotoMap
//
//  Created by luojie on 16/8/12.
//
//

import UIKit
import RxSwift
import RxCocoa

open class RxCollectionViewCell: UICollectionViewCell {
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        prepareForReuseDisposeBag = DisposeBag()
    }
    
    public private(set) var prepareForReuseDisposeBag = DisposeBag()
}

open class RxTableViewCell: UITableViewCell {
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        prepareForReuseDisposeBag = DisposeBag()
    }
    
    public private(set) var prepareForReuseDisposeBag = DisposeBag()

}
