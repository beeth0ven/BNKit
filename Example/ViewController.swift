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
        
//        Driver.just((0...30).map { "A\($0)" }) --> binder(tableView.rx.items(cellType: RxTableViewCell.self)) { row, text, cell in
//            cell.textLabel?.text = text
//            Observable<Int>.timer(10, scheduler: MainScheduler.instance).debug(text)
//                --> cell.binding { cell, count in }
//
//            
//        }
        
        Observable<TimeInterval>.timer(duration: 5)
            .subscribe(
                onNext: { remain in
                    print("剩余：", remain)
                },
                onCompleted: {
                    print("计时结束！")
                }
            )
            .addDisposableTo(disposeBag)
    }
}
