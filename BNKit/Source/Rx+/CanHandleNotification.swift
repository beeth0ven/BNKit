//
//  CanHandleNotification.swift
//  BNKit
//
//  Created by luojie on 2016/11/20.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public protocol CanHandleNotification {}
extension NSObject: CanHandleNotification {}

extension CanHandleNotification where Self: HasDisposeBag {
    
    public func observe(forNotification name: Notification.Name, sender: AnyObject? = nil, didReceive: @escaping ([AnyHashable : Any]?) -> Void) {
        NotificationCenter.default.rx.notification(name, object: sender).map { $0.userInfo }
            .subscribe(onNext: didReceive)
            .disposed(by: disposeBag)
    }
    
    public func post(notification name: Notification.Name, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
        let object = object ?? self
        NotificationCenter.default.post(name: name, object: object, userInfo: userInfo)
    }
}
