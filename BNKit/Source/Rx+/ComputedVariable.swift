//
//  ComputedVariable.swift
//  WorkMap
//
//  Created by luojie on 16/10/19.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public class ComputedVariable<Element> {
    
    public typealias E = Element

    private let _getter: () -> Element
    private let _setter: (Element) -> Void
    
    private let _subject: BehaviorSubject<Element>
    private var _lock = NSRecursiveLock()
    
    public var value: Element {
        get {
            _lock.lock(); defer { _lock.unlock() }
            return _getter()
        }
        set(newValue) {
            _lock.lock()
            _setter(newValue)
            _lock.unlock()
            _subject.on(.next(newValue))
        }
    }
    
    public init(getter: @escaping () -> Element, setter: @escaping (Element) -> Void) {
        _getter = getter
        _setter = setter
        _subject = BehaviorSubject(value: getter())
    }
    
    public func asObservable() -> Observable<E> {
        return _subject
    }
    
    deinit {
        _subject.on(.completed)
    }
}
