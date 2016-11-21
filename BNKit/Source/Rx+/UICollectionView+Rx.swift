//
//  UICollectionView+Rx.swift
//  BNKit
//
//  Created by luojie on 2016/11/21.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public typealias WillDisplayCollectionCellEvent = (cell: UICollectionViewCell, indexPath: IndexPath)

extension Reactive where Base: UICollectionView {
    
    public var willDisplayLastCell: Observable<WillDisplayCollectionCellEvent> {
        
        return willDisplayCell
            .filter { (_, indexPath) in
                let lastSection = self.base.numberOfSections - 1
                let lastRow = self.base.numberOfItems(inSection: lastSection) - 1
                return indexPath.section == lastSection && indexPath.row == lastRow
        }
    }
    
    public var willDisplayCell: ControlEvent<WillDisplayCollectionCellEvent> {
        let source: Observable<WillDisplayCollectionCellEvent> = self.delegate.methodInvoked(#selector(UICollectionViewDelegate.collectionView(_:willDisplay:forItemAt:)))
            .map { a in
                return (try castOrThrow(UICollectionViewCell.self, a[1]), try castOrThrow(IndexPath.self, a[2]))
        }
        
        return ControlEvent(events: source)
    }
    
    public func items<S: Sequence, Cell: UICollectionViewCell, O : ObservableType>
        (cellType: Cell.Type = Cell.self)
        -> (_ source: O)
        -> (_ configureCell: @escaping (Int, S.Iterator.Element, Cell) -> Void)
        -> Disposable
        where O.E == S  {
            return items(cellIdentifier: String(describing: cellType), cellType: cellType)
    }
}

extension Reactive where Base: UICollectionView {
    
    public func model<T>(at item: Int) throws -> T {
        let indexPath = IndexPath(item: item, section: 0)
        return try model(at: indexPath)
    }
}
