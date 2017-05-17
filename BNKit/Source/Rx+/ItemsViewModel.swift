//
//  ItemsViewModel.swift
//  BNKit
//
//  Created by luojie on 2017/5/17.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import RxSwift

public struct ItemsViewModel<Item, Param, Response> {
    
    // Input
    
    public let reloadTrigger: PublishSubject<Void> = .init()
    
    // Output
    
    public let items: Observable<[Item]>
    public let error: Observable<Error>
    public let isEmpty: Observable<Bool>
    public let isLoading: Observable<Bool>
    
    public init(
        getParam: @escaping () -> Param,
        mapToResponse: @escaping (Param) -> Observable<Response>,
        mapToItems: @escaping (Response) -> [Item]
        ) {
        
        // Input -> Output
        
        let _isLoading: BehaviorSubject<Bool> = .init(value: false)
        let _error: PublishSubject<Error> = .init()
        
        let _items: Observable<[Item]> = reloadTrigger
            .startWith(())
            .withLatestFrom(_isLoading) { _, loading in loading }
            .filter { loading in !loading }
            .mapToVoid()
            .map(getParam)
            .do(onNext: { _ in _isLoading.onNext(true) })
            .flatMapLatest { param -> Observable<[Item]> in
                mapToResponse(param)
                    .do(onNext: { _ in _isLoading.onNext(false) })
                    .do(onError: { _ in _isLoading.onNext(false) })
                    .map(mapToItems)
                    .do(onError: _error.onNext)
                    .catchError { _ in .empty() }
            }
            .shareReplay(1)
        
        let _isEmpty: Observable<Bool> = _items
            .withLatestFrom(_isLoading) { items, loading in items.isEmpty && !loading }
            .shareReplay(1)
        
        items       = _items.observeOnMainScheduler()
        isLoading   = _isLoading.observeOnMainScheduler()
        error       = _error.observeOnMainScheduler()
        isEmpty     = _isEmpty.observeOnMainScheduler()
    }
}

