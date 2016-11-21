//
//  UITableView+Rx.swift
//  WorkMap
//
//  Created by luojie on 16/9/29.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UITableView {
    
    public var willDisplayLastCell: Observable<WillDisplayCellEvent> {
        
        return willDisplayCell
            .filter { (_, indexPath) in
                let lastSection = self.base.numberOfSections - 1
                let lastRow = self.base.numberOfRows(inSection: lastSection) - 1
                return indexPath.section == lastSection && indexPath.row == lastRow
            }
    }
    
    /**
     ```swift
     ...
     .drive(tableView.rx.items(cellType: RxTableViewCell.self)) { index, invitation, cell in
        ...
     })
     .addDisposableTo(cell.prepareForReuseDisposeBag)
     }
     ```
     */
    public func items<S: Sequence, Cell: UITableViewCell, O : ObservableType>
        (cellType: Cell.Type = Cell.self)
        -> (_ source: O)
        -> (_ configureCell: @escaping (Int, S.Iterator.Element, Cell) -> Void)
        -> Disposable
        where O.E == S  {
        return items(cellIdentifier: String(describing: cellType), cellType: cellType)
    }
}


extension Reactive where Base: UITableView {
    
    public func model<T>(at row: Int) throws -> T {
        let indexPath = IndexPath(row: row, section: 0)
        return try model(at: indexPath)
    }
}
