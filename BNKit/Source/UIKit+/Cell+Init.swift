//
//  Cell+Init.swift
//  show
//
//  Created by luojie on 16/5/13.
//  Copyright © 2016年 @天意. All rights reserved.
//

import UIKit

// UITableViewCell
public protocol IsTableViewCell {}
extension UITableViewCell: IsTableViewCell {}
extension IsTableViewCell where Self: UITableViewCell {

    public static func dequeue(from tableView: UITableView) -> Self {
        let identifier = String(describing: self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? Self else  {
            fatalError("Can't get \(identifier) from tableView!")
        }
        return cell
    }
}

extension IsTableViewCell where Self: UITableViewCell, Self: HasModel {
    
    public static func dequeue(from tableView: UITableView, withModel model: Model!) -> Self {
        var cell = self.dequeue(from: tableView)
        cell.model = model
        return cell
    }
}


// UICollectionViewCell
public protocol IsCollectionViewCell {}
extension UICollectionViewCell: IsCollectionViewCell {}
extension IsCollectionViewCell where Self: UICollectionViewCell {

    public static func dequeue(from collectionView: UICollectionView, forIndexPath indexPath: IndexPath) -> Self {
        let identifier = String(describing: self)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Self else  {
            fatalError("Can't get \(identifier) from collectionView!")
        }
        return cell
    }
    
    public static func dequeue(from collectionView: UICollectionView, forIndex index: Int) -> Self {
        return dequeue(from: collectionView, forIndexPath: IndexPath(item: index, section: 0))
    }
}

extension IsCollectionViewCell where Self: UICollectionViewCell, Self: HasModel {
    
    public static func dequeue(from collectionView: UICollectionView, forIndexPath indexPath: IndexPath, withModel model: Model!) -> Self {
        var cell = self.dequeue(from: collectionView, forIndexPath: indexPath)
        cell.model = model
        return cell
    }
    
    public static func dequeue(from collectionView: UICollectionView, forIndex index: Int, withModel model: Model!) -> Self {
        return dequeue(from: collectionView, forIndexPath: IndexPath(item: index, section: 0), withModel: model)
    }
}
