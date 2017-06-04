//
//  SingleApiPaginationViewModel.swift
//  BNKit
//
//  Created by luojie on 2017/5/19.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import RxSwift

public struct SingleApiPaginationViewModel<Item, Param, Response, Cursor> {
    
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
        getReloadParam: @escaping () -> Param,
        mapToReloadResponse: @escaping (Param) -> Observable<Response>,
        mapToReloadCursor: @escaping (Response) -> Cursor?,
        mapToReloadItems: @escaping (Response) -> [Item],
        getNextPageParam: @escaping (Cursor) -> Param
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
            ) = SingleApiPaginationViewModel.create(
                getReloadParam: getReloadParam,
                mapToReloadResponse: mapToReloadResponse,
                mapToReloadCursor: mapToReloadCursor,
                mapToReloadItems: mapToReloadItems,
                getNextPageParam: getNextPageParam,
                mapToNextPageResponse: mapToReloadResponse,
                mapToNextPageCursor: mapToReloadCursor,
                mapToNextPageItems: mapToReloadItems
        )
    }
}

extension SingleApiPaginationViewModel: IsPaginationViewModel {
    
    public typealias IsItem = Item
    public typealias IsReloadParam = Param
    public typealias IsReloadResponse = Response
    public typealias IsCursor = Cursor
    public typealias IsNextPageParam = Param
    public typealias IsNextPageResponse = Response
}
