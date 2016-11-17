//
//  UIViewController+Alert.swift
//  WorkMap
//
//  Created by luojie on 16/11/1.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit
import RxSwift

extension UIViewController {
    
    public func showAlert(style: UIAlertControllerStyle = .alert, message: String, titles: [String]) -> Observable<String> {
        
        return Observable.create { [unowned self] observer in
            let vc = UIAlertController(title: nil, message: message, preferredStyle: style)
            titles.forEach { title in
                vc.addAction(UIAlertAction(title: title, style: .default, handler: { _ in
                    observer.onNext(title)
                    observer.onCompleted()
                }))
            }
            self.present(vc, animated: true, completion: nil)
            return Disposables.create()
        }
    }
}
