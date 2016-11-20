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

infix operator --> : DefaultPrecedence

public func --><OE: ObservableType, B, OR: ObserverType>(observable: OE, params: (base: B, observer: OR))
    where OR.E == OE.E, B: HasDisposeBag, B: AnyObject {
        observable.bindTo(params.observer).addDisposableTo(params.base.disposeBag)
}

public func --><OE: ObservableType, B, OR: ObserverType>(observable: OE, params: (base: B, observer: OR))
    where OR.E == OE.E?, B: HasDisposeBag, B: AnyObject {
        observable.bindTo(params.observer).addDisposableTo(params.base.disposeBag)
}

public func --><OE: ObservableType, B>(observable: OE, params: (base: B, variable: Variable<OE.E>))
    where B: HasDisposeBag, B: AnyObject {
        observable.bindTo(params.variable).addDisposableTo(params.base.disposeBag)
}

public func --><OE: ObservableType, B>(observable: OE, params: (base: B, variable: Variable<OE.E?>))
    where B: HasDisposeBag, B: AnyObject {
        observable.bindTo(params.variable).addDisposableTo(params.base.disposeBag)
}

public func --><OE: ObservableType, B, R1, R2: Disposable>(observable: OE, params: (base: B, binder: (OE) -> (R1) -> R2, curriedArgument: R1))
    where B: HasDisposeBag, B: AnyObject {
        observable.bindTo(params.binder, curriedArgument: params.curriedArgument).addDisposableTo(params.base.disposeBag)
}


extension HasDisposeBag where Self: UIResponder {
    
    func observer<E>(binding: @escaping (Self, E) -> Void) -> (base: Self, observer: UIBindingObserver<Self, E>) {
        let observer = UIBindingObserver(UIElement: self, binding: binding)
        return (self, observer)
    }
    
    func observer<E>(getter: @escaping (Self) -> UIBindingObserver<Self, E>) -> (base: Self, observer: UIBindingObserver<Self, E>) {
        return (self, getter(self))
    }
    
    func observer<E>(getter: @escaping (Self) -> UIBindingObserver<Self, E?>) -> (base: Self, observer: UIBindingObserver<Self, E?>) {
        return (self, getter(self))
    }
    
    func variable<E>(getter: @escaping (Self) -> Variable<E>) -> (base: Self, variable: Variable<E>) {
        return (self, getter(self))
    }
    
    func variable<E>(getter: @escaping (Self) -> Variable<E?>) -> (base: Self, variable: Variable<E?>) {
        return (self, getter(self))
    }
    
    func binder<OE: ObservableType, R1, R2: Disposable>(_ binder: @escaping (OE) -> (R1) -> R2, curriedArgument: R1) -> (base: Self, binder: (OE) -> (R1) -> R2, curriedArgument: R1) {
        return (self, binder, curriedArgument)
    }
    
}

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.rx.text.orEmpty --> observer { $0.rx.title }
        
        let tableView = UITableView()
        
//        let a = binder(tableView.rx.items(cellType: UITableViewCell.self), curriedArgument: { (row: Int, text: String, cell: UITableViewCell) -> Void in
//            
//        })
//        Observable.just([String]()).bindTo(tableView.rx.items(cellType: UITableViewCell.self), curriedArgument: { (row: Int, text: String, cell: UITableViewCell) -> Void in
//            
//        }).addDisposableTo(self.disposeBag)
//        
//        Observable.just([String]()) --> (self, tableView.rx.items(cellType: UITableViewCell.self), { (row: Int, text: String, cell: UITableViewCell) -> Void in
//            
//        })
//        
//        binder(tableView.rx.items(cellType: UITableViewCell.self), curriedArgument: { (row: Int, text: String, cell: UITableViewCell) -> Void in
//            
//        })

        
//        Observable.just([String]())
//            .bindTo(tableView.rx.items(cellType: UITableViewCell.self)) { tableView, row, text in
//                
//        }
//        .addDisposableTo(disposeBag)

    }
}

