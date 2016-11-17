//
//  ObservableType+.swift
//  WorkMap
//
//  Created by luojie on 16/10/17.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import RxSwift

extension ObservableType {
    
    public func observeOnMainScheduler() -> Observable<E> {
        return observeOn(MainScheduler.instance)
    }
    
    public func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}
