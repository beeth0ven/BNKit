//
//  BNKitTests.swift
//  BNKitTests
//
//  Created by luojie on 2017/5/21.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxDataSources
import RxBlocking
import RxTest
@testable import BNKit


class BNKitTests: XCTestCase {
    
    typealias Item = String
    typealias Param = Int
    typealias Response = (items: [String], nextPage: Int?)
    typealias Cursor = Int
    typealias ViewModel = SingleApiPaginationViewModel<Item, Param, Response, Cursor>
    
    var viewModel: ViewModel!
    var scheduler: ConcurrentDispatchQueueScheduler!
    var bag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        
        viewModel = ViewModel(
            getReloadParam: { 1 },
            mapToReloadResponse: apiCall,
            mapToReloadCursor: { $0.nextPage },
            mapToReloadItems: { $0.items },
            getNextPageParam: { $0 }
        )
        
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        bag = DisposeBag()
    }
    
    func testExample() {
        
        let expect = expectation(description: #function)
        
        print("\nLoading")

        viewModel.bind(
            items: { $0.subscribe(onNext: { print("items:", $0) }) },
            isReloading: { $0.subscribe(onNext: { print("isReloading:", $0) }) },
            reloadError: { $0.subscribe(onNext: { print("reloadError:", $0) }) },
            isLoadingNextPage: { $0.subscribe(onNext: { print("isLoadingNextPage:", $0) }) },
            loadNextPageError: { $0.subscribe(onNext: { print("loadNextPageError:", $0) }) },
            isEmpty: { $0.subscribe(onNext: { print("isEmpty:", $0) }) },
            hasNextPage: { $0.subscribe(onNext: { print("hasNextPage:", $0) }) }
        )
        .disposed(by: disposeBag)
        
        Observable<Int>.interval(10, scheduler: scheduler)
            .mapToVoid()
            .take(3)
            .do(onNext: { _ in print("\nNextPage") })
            .subscribe(
                onNext: viewModel.loadNextPageTrigger.onNext,
                onCompleted: expect.fulfill
            )
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 100) { (error) in
            XCTAssertEqual(1, 1)
        }

    }
    
    private func apiCall(page: Int) -> Observable<Response> {
        let maxPage = 3
        let items = (0..<10).map { (page - 1) * 10 + $0 }.map { $0.description }
        let nextPage = page < maxPage ? page + 1 : nil
        let response: Response = (items, nextPage)
        return Observable.just(response)
            .delay(1, scheduler: scheduler)
        
    }
    
    private func apiCallReturnEmpty(page: Int) -> Observable<Response> {
        let response: Response = ([], nil)
        return Observable.just(response)
            .delay(1, scheduler: scheduler)
        
    }
    
}
