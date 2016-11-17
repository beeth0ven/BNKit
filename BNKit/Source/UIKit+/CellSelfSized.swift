//
//  CellSelfSized.swift
//  PhotoMap
//
//  Created by luojie on 16/8/24.
//
//

import UIKit

extension UITableView {
    
    @IBInspectable
    public var cellSelfSized: Bool {
        
        get {
            
            return rowHeight == UITableViewAutomaticDimension
        }
        set(enable) {
            if enable {
                estimatedRowHeight = rowHeight
                rowHeight = UITableViewAutomaticDimension
            }
        }
    }
}

extension UICollectionView {
    
    @IBInspectable
    public var cellSelfSized: Bool {
        
        get {
            
            guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return false }
            return layout.estimatedItemSize != CGSize.zero
        }
        set(enable) {
            if enable {
                
                guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
                layout.estimatedItemSize = layout.itemSize
            }
        }
    }
}
