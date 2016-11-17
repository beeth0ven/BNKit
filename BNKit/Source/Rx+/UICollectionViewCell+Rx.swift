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

public class RxCollectionViewCell: UICollectionViewCell {
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        prepareForReuseDisposeBag = DisposeBag()
    }
    
    public private(set) var prepareForReuseDisposeBag = DisposeBag()
}

public class RxTableViewCell: UITableViewCell {
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        prepareForReuseDisposeBag = DisposeBag()
    }
    
    public private(set) var prepareForReuseDisposeBag = DisposeBag()

}
