//
//  ViewController.swift
//  Example
//
//  Created by luojie on 2016/11/16.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit
import BNKit
import RxSwift
import RxCocoa
import RxDataSources

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        Driver.just((0...30).map { "A\($0)" }) --> binder(tableView.rx.items()) { (row, text, cell: UITableViewCell) in
            cell.textLabel?.text = text
            
            Observable<TimeInterval>.timer(interval: 10, ascending: true).debug(text)
                --> cell.binding { cell, count in }
            
        }
        
    }
}

class ViewController1: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage.qrCode(from: "beeth0ven", tintColor: UIColor.brown)
    }
}
