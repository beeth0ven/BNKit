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
    
    public let reloadTrigger: PublishSubject<Void>
    public let loadNextPageTrigger: PublishSubject<Void>
    
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
        
        (
            self.reloadTrigger,
            self.loadNextPageTrigger,
            self.items,
            self.isReloading,
            self.reloadError,
            self.isLoadingNextPage,
            self.loadNextPageError,
            self.isEmpty,
            self.hasNextPage
            ) = PaginationViewModel.create(
                getReloadParam: getReloadParam,
                mapToReloadResponse: mapToReloadResponse,
                mapToReloadCursor: mapToReloadCursor,
                mapToReloadItems: mapToReloadItems,
                getNextPageParam: getNextPageParam,
                mapToNextPageResponse: mapToNextPageResponse,
                mapToNextPageCursor: mapToNextPageCursor,
                mapToNextPageItems: mapToNextPageItems
        )
        
    }
}

extension PaginationViewModel: IsPaginationViewModel {
    
    public typealias IsItem = Item
    public typealias IsReloadParam = ReloadParam
    public typealias IsReloadResponse = ReloadResponse
    public typealias IsCursor = Cursor
    public typealias IsNextPageParam = NextPageParam
    public typealias IsNextPageResponse = NextPageResponse
}

public protocol IsPaginationViewModel {
    
    associatedtype IsItem
    associatedtype IsReloadParam
    associatedtype IsReloadResponse
    associatedtype IsCursor
    associatedtype IsNextPageParam
    associatedtype IsNextPageResponse
    
    // Input
    
    var reloadTrigger: PublishSubject<Void> { get }
    var loadNextPageTrigger: PublishSubject<Void> { get }
    
    // Output
    
    var items: Observable<[IsItem]> { get }
    var isReloading: Observable<Bool> { get }
    var reloadError: Observable<Error> { get }
    var isLoadingNextPage: Observable<Bool> { get }
    var loadNextPageError: Observable<Error> { get }
    var isEmpty: Observable<Bool> { get }
    var hasNextPage: Observable<Bool> { get }
}

extension IsPaginationViewModel {
    
    public static func create(
        getReloadParam: @escaping () -> IsReloadParam,
        mapToReloadResponse: @escaping (IsReloadParam) -> Observable<IsReloadResponse>,
        mapToReloadCursor: @escaping (IsReloadResponse) -> IsCursor?,
        mapToReloadItems: @escaping (IsReloadResponse) -> [IsItem],
        getNextPageParam: @escaping (IsCursor) -> IsNextPageParam,
        mapToNextPageResponse: @escaping (IsNextPageParam) -> Observable<IsNextPageResponse>,
        mapToNextPageCursor: @escaping (IsNextPageResponse) -> IsCursor?,
        mapToNextPageItems: @escaping (IsNextPageResponse) -> [IsItem]
        ) -> (
        reloadTrigger: PublishSubject<Void>,
        loadNextPageTrigger: PublishSubject<Void>,
        items: Observable<[IsItem]>,
        isReloading: Observable<Bool>,
        reloadError: Observable<Error>,
        isLoadingNextPage: Observable<Bool>,
        loadNextPageError: Observable<Error>,
        isEmpty: Observable<Bool>,
        hasNextPage: Observable<Bool>
        ) {
            
            let reloadTrigger: PublishSubject<Void> = .init()
            let loadNextPageTrigger: PublishSubject<Void> = .init()
            
            // Input -> Output
            
            let _isReloading: BehaviorSubject<Bool> = .init(value: false)
            let _reloadError: PublishSubject<Error> = .init()
            let _isLoadingNextPage: BehaviorSubject<Bool> = .init(value: false)
            let _loadNextPageError: PublishSubject<Error> = .init()
            
            let _cursor: ReplaySubject<IsCursor?> = .create(bufferSize: 1)
            
            let _isLoading: Observable<Bool> = Observable.combineLatest(
                _isReloading,
                _isLoadingNextPage)
            { isReloading, isLoadingNextPage in isReloading || isLoadingNextPage }
                .shareReplay(1)
            
            let _reloadedItems: Observable<[IsItem]> = reloadTrigger
                .startWith(())
                .withLatestFrom(_isLoading) { _, loading in loading }
                .filter { loading in !loading }
                .mapToVoid()
                .map(getReloadParam)
                .do(onNext: { _ in _isReloading.onNext(true) })
                .flatMapLatest { param -> Observable<[IsItem]> in
                    mapToReloadResponse(param)
                        .do(onNext: { _ in _isReloading.onNext(false) })
                        .do(onError: { _ in _isReloading.onNext(false) })
                        .do(onNext: { response in _cursor.onNext(mapToReloadCursor(response)) })
                        .map(mapToReloadItems)
                        .do(onError: _reloadError.onNext)
                        .catchError { _ in .empty() }
                }
                .shareReplay(1)
            
            let _nextPageItems: Observable<[IsItem]> = loadNextPageTrigger
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
            
            let _items: Observable<[IsItem]> = Observable.merge(
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
            
            
            return (
                reloadTrigger,
                loadNextPageTrigger,
                _items.observeOnMainScheduler().skip(1),
                _isReloading.observeOnMainScheduler(),
                _reloadError.observeOnMainScheduler(),
                _isLoadingNextPage.observeOnMainScheduler().skip(1),
                _loadNextPageError.observeOnMainScheduler(),
                _isEmpty.observeOnMainScheduler().skip(1),
                _hasNextPage.observeOnMainScheduler()
            )
            
    }
}

extension IsPaginationViewModel {
    
    public func bind(
        items bindItems: (Observable<[IsItem]>) -> Disposable,
        isReloading bindIsReloading: (Observable<Bool>) -> Disposable = { _ in Disposables.create() },
        reloadError bindReloadError: (Observable<Error>) -> Disposable = { _ in Disposables.create() },
        isLoadingNextPage bindIsLoadingNextPage: (Observable<Bool>) -> Disposable = { _ in Disposables.create() },
        loadNextPageError bindLoadNextPageError: (Observable<Error>) -> Disposable = { _ in Disposables.create() },
        isEmpty bindIsEmpty: (Observable<Bool>) -> Disposable = { _ in Disposables.create() },
        hasNextPage bindHasNextPage: (Observable<Bool>) -> Disposable = { _ in Disposables.create() }
        ) -> Disposable {
        
        return CompositeDisposable(disposables: [
            bindItems(self.items),
            bindIsReloading(self.isReloading),
            bindReloadError(self.reloadError),
            bindIsLoadingNextPage(self.isLoadingNextPage),
            bindLoadNextPageError(self.loadNextPageError),
            bindIsEmpty(self.isEmpty),
            bindHasNextPage(self.hasNextPage)
            ])
    }
}

private func strongify<WeakOwner, E>(_ owner: WeakOwner, _ closure: @escaping (WeakOwner, E) -> Void)
    -> (E) -> Void where WeakOwner: AnyObject {
        return { [weak owner] value in
            guard let strongOwner = owner else {
                return
            }
            closure(strongOwner, value)
        }
}
