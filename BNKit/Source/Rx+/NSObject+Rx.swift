//
//  NSObject+Rx.swift
//  PhotoMap
//
//  Created by luojie on 16/8/10.
//
//

import Foundation
import RxSwift
import RxCocoa

public protocol HasDisposeBag {
    var disposeBag: DisposeBag { get }
}

extension NSObject: HasDisposeBag {
    
    public var disposeBag: DisposeBag {
        
        switch objc_getValue(key: &AssociatedKeys.disposeBag) {
        case let disposeBag as DisposeBag:
            return disposeBag
        default:
            let disposeBag = DisposeBag()
            objc_set(value: disposeBag, key: &AssociatedKeys.disposeBag)
            return disposeBag
        }
    }
}

private enum AssociatedKeys {
    static var disposeBag = "disposeBag"
}

public protocol CanHandleNotification {}
extension NSObject: CanHandleNotification {}

extension CanHandleNotification where Self: HasDisposeBag {
    
    public func observe(forNotification name: Notification.Name, sender: AnyObject? = nil, didReceive: @escaping ([AnyHashable : Any]?) -> Void) {
        NotificationCenter.default.rx.notification(name, object: sender).map { $0.userInfo }
            .subscribe(onNext: didReceive)
            .addDisposableTo(disposeBag)
    }
    
    public func post(notification name: Notification.Name, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
        let object = object ?? self
        NotificationCenter.default.post(name: name, object: object, userInfo: userInfo)
    }
}
