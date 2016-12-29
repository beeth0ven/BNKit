//
//  Cell+Init.swift
//  show
//
//  Created by luojie on 16/5/13.
//  Copyright © 2016年 @天意. All rights reserved.
//

import UIKit

public protocol IsTableViewCell {}
extension UITableViewCell: IsTableViewCell {}
extension IsTableViewCell where Self: UITableViewCell {
    /**
     ### Usage Example: ###
     ```swift
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let chatCell = ChatTableViewCell.fromTableView(tableView)
        return chatCell
    }
     ```
     */
    public static func from(_ tableView: UITableView, configure: ((Self) -> Void) = { _ in }) -> Self {
        let identifier = String(describing: self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? Self else  {
            fatalError("Can't get \(identifier) from tableView!")
        }
        configure(cell)
        return cell
    }
}


public protocol IsCollectionViewCell {}
extension UICollectionViewCell: IsCollectionViewCell {}
extension IsCollectionViewCell where Self: UICollectionViewCell {
    /**
     ### Usage Example: ###
     ```swift
    let bannerCell = BannerCollectionViewCell.fromCollectionView(collectionView, forIndexPath: indexPath)
     ```
     */
    public static func from(_ collectionView: UICollectionView, forIndexPath indexPath: IndexPath, configure: ((Self) -> Void) = { _ in }) -> Self {
        let identifier = String(describing: self)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Self else  {
            fatalError("Can't get \(identifier) from collectionView!")
        }
        configure(cell)
        return cell
    }
    
    public static func from(_ collectionView: UICollectionView, forIndex index: Int, configure: ((Self) -> Void) = { _ in }) -> Self {
        let indexPath = IndexPath(item: index, section: 0)
        return self.from(collectionView, forIndexPath: indexPath, configure: configure)
    }
}
