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
        
        Driver.just(["00", "11", "22"]) --> observer(tableView.rx.items(cellType: UITableViewCell.self)) { row, text, cell in
            cell.textLabel?.text = text
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let text = try! tableView.rx.model(at: 0) as String
        print("text", text)
    }
}
