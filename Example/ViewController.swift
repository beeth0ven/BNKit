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
    
    typealias Section = SectionModel<String, String>
    
    let dataSource = RxTableViewSectionedReloadDataSource<Section>()
    
    let rxText = Variable("")

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.rx.text.orEmpty --> observer { $0.title = $1 }
        
        textField.rx.textInput <-> variable { $0.rxText }
        
        rxText.asDriver() --> observer { print("rxText", $1) }
        
        let tableView = UITableView()
        
        Driver.just([Section]()) --> observer(tableView.rx.items(dataSource: dataSource))

    }
}

