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
                
//        Driver.just((0...30).map { "A\($0)" }) --> binder(tableView.rx.items()) { (row, text, cell: UITableViewCell) in
//            cell.textLabel?.text = text
//            
//            Observable<TimeInterval>.timer(interval: 10, ascending: true).debug(text)
//                --> cell.binding { cell, count in }
//            
//        }
        
        navigationItem.rightBarButtonItem!.rx.tap
            .subscribe(onNext: { TableViewController.shared.rx.refreshTrigger.onNext() })
            .disposed(by: disposeBag)
    }
}

class TableViewController: UITableViewController {
    
    static var shared: TableViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableViewController.shared = self
        
        rx._refreshTrigger
            .debug("_refreshTrigger")
            .subscribe()
            .disposed(by: disposeBag)
    }
}


class ScanQRCodeViewController: UIViewController {
    
    @IBOutlet weak var getQRCodeView: GetQRCodeView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getQRCodeView.value
//            .debounce(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
}
