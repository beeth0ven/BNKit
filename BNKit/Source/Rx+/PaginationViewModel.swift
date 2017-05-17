//
//  PaginationViewModel.swift
//  BNKit
//
//  Created by luojie on 2017/5/17.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import RxSwift

public struct PaginationViewModel<Item, ReloadParam, ReloadResponse, Cursor, NextPageParam, NextPageResponse> {
    
    // Input
    
    public let reloadTrigger: PublishSubject<Void> = .init()
    public let loadNextPageTrigger: PublishSubject<Void> = .init()
    
    // Output
    
    public let items: Observable<[Item]>
    public let isReloading: Observable<Bool>
    public let reloadError: Observable<Error>
    public let isLoadingNextPage: Observable<Bool>
    public let loadNextPageError: Observable<Error>
    public let isEmpty: Observable<Bool>
    public let hasNextPage: Observable<Bool>
    
    
    public init(
        getReloadParam: @escaping () -> ReloadParam,
        mapToReloadResponse: @escaping (ReloadParam) -> Observable<ReloadResponse>,
        mapToReloadCursor: @escaping (ReloadResponse) -> Cursor?,
        mapToReloadItems: @escaping (ReloadResponse) -> [Item],
        getNextPageParam: @escaping (Cursor) -> NextPageParam,
        mapToNextPageResponse: @escaping (NextPageParam) -> Observable<NextPageResponse>,
        mapToNextPageCursor: @escaping (NextPageResponse) -> Cursor?,
        mapToNextPageItems: @escaping (NextPageResponse) -> [Item]
        ) {
        
        
        // Input -> Output
        
        let _isReloading: BehaviorSubject<Bool> = .init(value: false)
        let _reloadError: PublishSubject<Error> = .init()
        let _isLoadingNextPage: BehaviorSubject<Bool> = .init(value: false)
        let _loadNextPageError: PublishSubject<Error> = .init()
        
        let _cursor: ReplaySubject<Cursor?> = .create(bufferSize: 1)
        
        let _isLoading: Observable<Bool> = Observable.combineLatest(
            _isReloading,
            _isLoadingNextPage)
        { isReloading, isLoadingNextPage in isReloading || isLoadingNextPage }
            .shareReplay(1)
        
        let _reloadedItems: Observable<[Item]> = reloadTrigger
            .startWith(())
            .withLatestFrom(_isLoading) { _, loading in loading }
            .filter { loading in !loading }
            .mapToVoid()
            .map(getReloadParam)
            .do(onNext: { _ in _isReloading.onNext(true) })
            .flatMapLatest { param -> Observable<[Item]> in
                mapToReloadResponse(param)
                    .do(onNext: { _ in _isReloading.onNext(false) })
                    .do(onError: { _ in _isReloading.onNext(false) })
                    .do(onNext: { response in _cursor.onNext(mapToReloadCursor(response)) })
                    .map(mapToReloadItems)
                    .do(onError: _reloadError.onNext)
                    .catchError { _ in .empty() }
            }
            .shareReplay(1)
        
        let _nextPageItems: Observable<[Item]> = loadNextPageTrigger
            .withLatestFrom(_isLoading) { _, loading in loading }
            .filter { loading in !loading }
            .withLatestFrom(_cursor)
            .filter { optional in optional != nil }
            .map { cursor in cursor! }
            .map(getNextPageParam)
            .do(onNext: { _ in _isLoadingNextPage.onNext(true) })
            .flatMapLatest { param in
                mapToNextPageResponse(param)
                    .do(onNext: { _ in _isLoadingNextPage.onNext(false) })
                    .do(onError: { _ in _isLoadingNextPage.onNext(false) })
                    .do(onNext: { response in _cursor.onNext(mapToNextPageCursor(response)) })
                    .map(mapToNextPageItems)
                    .do(onError: _loadNextPageError.onNext)
                    .catchError { _ in .empty() }
            }
            .shareReplay(1)
        
        let _items: Observable<[Item]> = Observable.merge(
            _isReloading.filter { loading in loading }.map { _ in ("replace", []) },
            _reloadedItems.map { reloadedItems in ("replace", reloadedItems) },
            _nextPageItems.map { nextPageItems in ("add", nextPageItems) }
            )
            .scan([]) { (items, tuple) in
                switch (tuple.0) {
                case "replace":
                    return tuple.1
                case "add":
                    return items + tuple.1
                default:
                    return items;
                }
            }
            .shareReplay(1)
        
        let _isEmpty: Observable<Bool> = _items
            .withLatestFrom(_isLoading) { items, loading in items.isEmpty && !loading }
            .shareReplay(1)
        
        let _hasNextPage: Observable<Bool> = _cursor.map { optional in optional != nil }
        
        items               = _items.observeOnMainScheduler()
        isReloading         = _isReloading.observeOnMainScheduler()
        reloadError         = _reloadError.observeOnMainScheduler()
        isLoadingNextPage   = _isLoadingNextPage.observeOnMainScheduler()
        loadNextPageError   = _loadNextPageError.observeOnMainScheduler()
        isEmpty             = _isEmpty.observeOnMainScheduler()
        hasNextPage         = _hasNextPage.observeOnMainScheduler()
    }
}
