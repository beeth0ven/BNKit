//
//  RegularExpressionTextField.swift
//  WorkMap
//
//  Created by luojie on 2016/11/13.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

open class RegularExpressionTextField: UITextField {
    
    @IBInspectable
    open var regularName: String = "default"
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        typealias Values = (old: String?, new: String?)
        
        Observable.zip(rx.text.startWith(""), rx.text) { (oldText, newText) -> Values in (oldText, newText) }
            .subscribe(onNext: { [unowned self] (oldText, newText) in
                print("text did set", oldText!, newText!)
                guard newText! =~ self.regularPattern.input else {
                    self.text = oldText
                    return
                }
            })
            .addDisposableTo(disposeBag)
    }
    
    open var isValid: Observable<Bool> {
        return rx.text.map { [unowned self] in
            $0! =~ self.regularPattern.valid
        }
    }
    
    override open var text: String? {
        didSet { sendActions(for: .valueChanged) }
    }
    
    private var regularPattern: RegularPattern {
        return RegularPattern.all[regularName]!
    }
}
