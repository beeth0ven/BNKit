//
//  UIImagePickerController+Rx.swift
//  Rx
//
//  Created by Segii Shulga on 1/4/16.
//  Copyright © 2016 Krunoslav Zaher. All rights reserved.
//

import Foundation

#if os(iOS)
    import Foundation
    
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif
    import UIKit
    
    extension Reactive where Base: UIImagePickerController {
        
        /**
         Reactive wrapper for `delegate` message.
         */
        public var didFinishPickingMediaWithInfo: Observable<[String : AnyObject]> {
            return self.delegate
                .methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerController(_:didFinishPickingMediaWithInfo:)))
                .map({ (a) in
                    return try castOrThrow(Dictionary<String, AnyObject>.self, a[1])
                })
                .do(onNext: { _ in self.base.presentingViewController?.dismiss(animated: true, completion: nil) })
        }
        
        /**
         Reactive wrapper for `delegate` message.
         */
        public var didCancel: Observable<()> {
            return self.delegate
                .methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerControllerDidCancel(_:)))
                .map {_ in () }
                .do(onNext: { _ in self.base.presentingViewController?.dismiss(animated: true, completion: nil) })

        }
        
    }
    
#endif

public func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    
    return returnValue
}
