//
//  HasDisposeBag.swift
//  PhotoMap
//
//  Created by luojie on 16/8/10.
//
//

import Foundation
import RxSwift
import RxCocoa

public protocol HasDisposeBag {
    /// Default DisposeBag
    var disposeBag: DisposeBag { get }
}

extension NSObject: HasDisposeBag {}

extension HasDisposeBag where Self: ObjectiveCompatible, Self: NSObject {
    

    public var disposeBag: DisposeBag {
        return objc.findOrCreateValue(forKey: &Keys.disposeBag, createValue: { DisposeBag() })
    }
}

private enum Keys {
    static var disposeBag = "disposeBag"
}


