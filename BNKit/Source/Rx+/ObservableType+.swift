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

extension ObservableType {
    
    public func withLatestFrom<SecondO, ThirdO, ResultType>(_ second: SecondO, _ third: ThirdO ,resultSelector: @escaping (Self.E, SecondO.E, ThirdO.E) throws -> ResultType) -> RxSwift.Observable<ResultType> where SecondO : ObservableConvertibleType, ThirdO : ObservableConvertibleType {
        return withLatestFrom(second) { $0 }
            .withLatestFrom(third) { (params, param2) in try resultSelector(params.0, params.1, param2) }
    }
}
